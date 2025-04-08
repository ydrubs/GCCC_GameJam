Enemy_Controller = {
    enemies = {},
    enemies_pool = {},
}

function Enemy_Controller:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self

    return o
end

function Enemy_Controller:init()
    self.enemies = {}
    for i = 1, 5 do
        local enemy = Enemy:new{x = rnd(127 - 33 - 8), y = 1}
        Log("Enemy "..i.." created at position: ("..enemy.x..", "..enemy.y..")")
        self.enemies[#self.enemies + 1] = enemy
    end
    self.enemies_pool = {}
end

function Enemy_Controller:update()
    -- Update the enemies
    for i = 1, #self.enemies do
        self.enemies[i]:move()

        self.enemies[i]:check_out_of_bounds()
    end
end

function Enemy_Controller:draw()
    -- Draw the enemies
    for i = 1, #self.enemies do
        self.enemies[i]:draw()
    end
end