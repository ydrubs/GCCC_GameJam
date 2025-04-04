Player = {
    x = 0,
    y = 0,
    speed = 2,
}

function Player:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self

    self:init(o.x, o.y) -- Initialize player position

    return o
end

function Player:init(x, y)
    self.x = x
    self.y = y
end

function Player:update()
    -- Update player position based on input
    if btn(0) then self.x = self.x - self.speed end -- Left
    if btn(1) then self.x = self.x + self.speed end -- Right

    self:check_out_of_bounds() -- Check if out of bounds
end

function Player:draw()
    -- Draw the player sprite at the current position
    spr(1, self.x, self.y) -- Assuming sprite 1 is the player sprite
end

function Player:check_out_of_bounds()
    -- Check if the player is out of bounds and reset position if necessary
    if self.x < 0 then 
        self.x = 0 
    end
    
    if self.x > 127 - 33 - 8 then 
        self.x = 127 - 33 - 8
    end

end