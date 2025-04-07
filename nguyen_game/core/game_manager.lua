Game_Manager = {
    player = nil,

    projectiles = {},
    projectiles_pool = {},
    id = 1,
}

function Game_Manager:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self

    return o
end

function Game_Manager:init()
    self.player = Player:new{x = 47-8, y = 100}
    self.projectiles = {}
    self.projectiles_pool = {}
end

function Game_Manager:update()
    -- Get input from the player
    if btn(0) then self.player:move(-1) end -- Left
    if btn(1) then self.player:move(1) end -- Right

    while #self.projectiles > 0 and self.projectiles[1].disable == true do
        local projectile = dequeue(self.projectiles)
        enqueue(self.projectiles_pool, projectile)
        Log("Pool projectile: " .. projectile.id)
    end

    if btnp(5) then
        if #self.projectiles_pool == 0 then
            local projectile = Projectile:new{x = self.player.x, y = self.player.y}
            projectile:set_id(self.id) -- Set the id of the projectile
            enqueue(self.projectiles, projectile)
            self.id += 1
        else
            local projectile = dequeue(self.projectiles_pool)
            projectile:set_position(self.player.x, self.player.y) 
            self.projectiles[#self.projectiles + 1] = projectile
            projectile:set_active() -- Set the projectile to active
        end

        Log("Create projectile: " .. self.projectiles[#self.projectiles].id)
    end

    for i = 1, #self.projectiles do
        self.projectiles[i]:update()
        if self.projectiles[i]:check_out_of_bounds() then
            self.projectiles[i]:set_disable()
            Log("Mark disable: " .. self.projectiles[i].id)
        end
    end

    
end

function Game_Manager:draw()
    self.player:draw()

    for i = 1, #self.projectiles do
        self.projectiles[i]:draw()
    end

    print("lst: " .. #self.projectiles, 97, 110)
    print("pool: " .. #self.projectiles_pool, 97, 120)
end

function Game_Manager:remove_item_from_pool()
    local item = self.projectiles_pool[#self.projectiles_pool]
    self.projectiles_pool[#self.projectiles_pool] = nil -- Remove the last item from the pool
    return item
end