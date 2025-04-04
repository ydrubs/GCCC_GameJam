Projectile = {
    -- The projectile's position
    x = 64,
    y = 64,

    -- The projectile's speed
    speed = 1,

    -- The projectile's image
    image = 0,

    -- The projectile's direction
    direction = -1,
}

function Projectile:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    
    return o
end

function Projectile:init(x, y, speed, image, direction)
    self.x = x
    self.y = y
    self.speed = speed
    self.image = image
    self.direction = direction
end

function Projectile:update()
    self.y = self.y + self.speed * self.direction
end

function Projectile:draw()
    spr(self.image, self.x, self.y)
end