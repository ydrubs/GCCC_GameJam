Enemy_Controller = {
    enemies_ready = {},
    enemies_active = {},
    enemies_pool = {},
}

function Enemy_Controller:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self

    return o
end

function Enemy_Controller:init()
    self.enemies_ready = {}
    self.enemies_active = {}

    for i = 1, 3 do
        local enemy = Enemy:new{x = rnd(127 - 33 - 8), y = 1, ready_time = rnd({1, 3})*30}
        Log("Enemy "..i.." created at position: ("..enemy.x..", "..enemy.y.. ", " ..enemy.ready_time..")")
        self.enemies_ready[#self.enemies_ready + 1] = enemy
    end

    self.enemies_pool = {}
end

function Enemy_Controller:update()
    -- Update the enemies
    count = 1

    while #self.enemies_ready > 0 and count <= #self.enemies_ready do
        -- Log("Count: "..count)
        -- Log("Number of enemies in ready: "..#self.enemies_ready)
        -- Check if the enemy is ready to be activated
        -- stop()
        self.enemies_ready[count]:get_ready()
        -- Check if the enemy is ready to be moved to active

        Log("TIME: "..count.. " " ..self.enemies_ready[count].ready_time)


        if self.enemies_ready[count].ready_time <= 0 then
            -- Move the enemy from ready to active
            local enemy = dequeue(self.enemies_ready)
            -- Log("Dequeue enemy "..count.." at position: ("..enemy.x..", "..enemy.y.. ", " ..enemy.ready_time..")")
            enqueue(self.enemies_active, enemy)
            count = count - 1
        end
        count += 1
    end

    -- for i = 1, #self.enemies_ready do
    --     -- Check if the enemy is ready to be activated
    --     self.enemies_ready[i]:get_ready()
    --     -- Check if the enemy is ready to be moved to active
    --     if self.enemies_ready[i].ready_time <= 0 then
    --         -- Move the enemy from ready to active
    --         local enemy = dequeue(self.enemies_ready)
    --         enqueue(self.enemies_active, enemy)
    --     end
    -- end

    for i = 1, #self.enemies_active do
        self.enemies_active[i]:move()

        self.enemies_active[i]:check_out_of_bounds()
    end
end

function Enemy_Controller:draw()
    -- Draw the enemies_active
    for i = 1, #self.enemies_active do
        self.enemies_active[i]:draw()
    end
end