Enemy = {
    x = 0,
    y = 0,
    speed = 2,
}

function Enemy:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self

    self:init(o.x, o.y) -- Initialize Enemy position

    return o
end

function Enemy:init(x, y)
    self.x = x
    self.y = y
end

function Enemy:on_collision()

end

function Enemy:move()
    self.y = self.y + self.speed
    self:check_out_of_bounds() -- Check if out of bounds
end


function Enemy:draw()
    spr(2, self.x, self.y) 
end

function Enemy:check_out_of_bounds()
    -- Check if the Enemy is out of bounds and reset position if necessary
    if self.y < 0 then 
        self.y = 0 
    end
    
    if self.y > 127 - 33 - 8 then 
        self.y = 127 - 33 - 8
    end
end
