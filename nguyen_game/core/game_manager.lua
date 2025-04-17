Game_Manager = {
    player = nil,
    projectile_controller = nil,
}

function Game_Manager:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self

    return o
end

function Game_Manager:init()
    self.player = Player:new{x = 47-8, y = 100}
    self.projectile_controller = Projectile_Controller:new()
end

function Game_Manager:update()

    -- Get input from the player    
    if btn(0) then self.player:move(-1) end -- Left
    if btn(1) then self.player:move(1) end -- Right

    -- Add projectile to the pool if it is disabled
    self.projectile_controller:add_projectile_to_pool()

    -- Check if the player is pressing the shoot button (X)
    if btnp(5) then
        self.projectile_controller:get_projectile(self.player.x, self.player.y)
    end

    self.projectile_controller:update()
    
end

function Game_Manager:draw()
    self.player:draw()
    self.projectile_controller:draw()
end

