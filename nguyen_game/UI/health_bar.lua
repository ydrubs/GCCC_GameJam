Health_Bar = {
    heart_sprite = 9, 
    empty_sprite = 10,
    max_lives = 3,
    lives = 3
}

function Health_Bar:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self

    return o
end

function Health_Bar:draw()
    -- Formula: screen_width - index * (sprite_width + sprite_spacing) - sprite_width - padding
    -- Space for health bar = 3 * 8 + 2 = 26
    -- Space for padding = 32 - 26 = 6

    for i = 1, self.max_lives do
        if (i > self.lives) do
            spr(self.empty_sprite, 128 - (i - 1) * 9 - 8 - 6/2, 4)
        else 
            spr(self.heart_sprite, 128 - (i - 1) * 9 - 8 - 6/2, 4)
        end        
    end
end

