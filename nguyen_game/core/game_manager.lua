Game_Manager = {
    player = nil,

    projectiles = {},
    projectiles_pool = {},

    enemy_controller = nil,
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

    -- Try to take each controller and put them in the game manager
    -- Try projectile_controller later 
    self.enemy_controller = Enemy_Controller:new()
    self.enemy_controller:init()
end

function Game_Manager:update()
    self.enemy_controller:update()

    -- Get input from the player    
    if btn(0) then self.player:move(-1) end -- Left
    if btn(1) then self.player:move(1) end -- Right

    -- Add projectile to the pool if it is disabled
    self:add_projectile_to_pool(self.projectiles, self.projectiles_pool)

    -- Check if the player is pressing the shoot button (X)
    if btnp(5) then
        -- Check if the player has any projectiles in the pool
        -- If not, create a new projectile
        if #self.projectiles_pool == 0 then
            local projectile = Projectile:new{x = self.player.x, y = self.player.y}
            enqueue(self.projectiles, projectile)

        -- If there are projectile in the pool, reuse this from taking from pool
        else
            local projectile = dequeue(self.projectiles_pool)
            projectile:set_position(self.player.x, self.player.y) 
            self.projectiles[#self.projectiles + 1] = projectile
            projectile:set_active() -- Set the projectile to active
        end
    end

    --Update the projectile
    for i = 1, #self.projectiles do
        self.projectiles[i]:update()

        -- Check if the projectile is going out the screen
        if self.projectiles[i]:check_out_of_bounds() then
            self.projectiles[i]:set_disable()
        end
    end

    
end

function Game_Manager:draw()
    self.enemy_controller:draw()
    self.player:draw()

    for i = 1, #self.projectiles do
        self.projectiles[i]:draw()
    end

    print("lst: " .. #self.projectiles, 97, 110)
    print("pool: " .. #self.projectiles_pool, 97, 120)
    print("enemy: " .. #self.enemy_controller.enemies, 97, 100)
end

function Game_Manager:add_projectile_to_pool(lst, pool)
    while #lst > 0 and lst[1].disable == true do
        local projectile = dequeue(lst)
        enqueue(pool, projectile)
    end
end