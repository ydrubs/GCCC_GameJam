Projectile_Controller = {
    projectiles = {},
    projectiles_pool = {},
}

function Projectile_Controller:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    self:init()
    return o
end

function Projectile_Controller:init()
    self.projectiles = {}
    self.projectiles_pool = {}
end


function Projectile_Controller:update()
    --Update the projectile
    for i = 1, #self.projectiles do
        self.projectiles[i]:update()
        
        -- Check if the projectile is going out the screen
        if self.projectiles[i]:check_out_of_bounds() then
            self.projectiles[i]:set_disable()
        end
    end
end

function Projectile_Controller:draw()
    for i = 1, #self.projectiles do
        self.projectiles[i]:draw()
    end
    
    print("lst: " .. #self.projectiles, 97, 110)
    print("pool: " .. #self.projectiles_pool, 97, 120)
end

function Projectile_Controller:add_projectile_to_pool()
    while #self.projectiles > 0 and self.projectiles[1].disable == true do
        local projectile = dequeue(self.projectiles)
        enqueue(self.projectiles_pool, projectile)
    end
end

function Projectile_Controller:create_projectile(posx, posy)
    local projectile = Projectile:new{x = posx, y = posy}
    enqueue(self.projectiles, projectile)
end

function Projectile_Controller:get_projectile_from_pool(posx, posy)
    local projectile = dequeue(self.projectiles_pool)
    projectile:set_position(posx, posy) 
    self.projectiles[#self.projectiles + 1] = projectile
    projectile:set_active() -- Set the projectile to active
end

function Projectile_Controller:get_projectile(posx, posy)
    -- Check if the player has any projectiles in the pool
    -- If not, create a new projectile
    if #self.projectiles_pool == 0 then
        self:create_projectile(posx, posy)
        
        -- If there are projectile in the pool, reuse this from taking from pool
    else
        self:get_projectile_from_pool(posx, posy)
    end
end


