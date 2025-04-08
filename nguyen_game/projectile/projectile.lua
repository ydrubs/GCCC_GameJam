Projectile = {
    -- The projectile's position
    x = 64,
    y = 64,

    -- The projectile's speed
    speed = 5,

    -- The projectile's image
    image = 0,

    -- The projectile's direction
    direction = -1,

    -- The projectile's disable flag
    disable = false,
}

function Projectile:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self

    return o
end

function Projectile:update()
    self.y = self.y + self.speed * self.direction
end

function Projectile:draw()
    spr(self.image, self.x, self.y)
end

function Projectile:set_position(x, y)
    self.x = x
    self.y = y
end

function Projectile:set_speed(speed)
    self.speed = speed
end

function Projectile:set_disable()
    self.disable = true
end

function Projectile:set_active()
    self.disable = false
end

function Projectile:check_out_of_bounds()
    if self.y < 0 then
        return true
    end

    return false
end