HUD = {
    health_bar = nil,
    side_bar = nil,
}

function HUD:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self

    -- Initialize the health bar and side bar
    self.health_bar = Health_Bar:new()
    self.side_bar = Side_Bar:new()

    return o
end

function HUD:draw()
    self.side_bar:draw()
    self.health_bar:draw()
end