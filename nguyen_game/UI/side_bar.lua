Side_Bar = {
    width = 33,
    height = 128,

    color = 7,
    sub_color = 5,

}

function Side_Bar:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self

    return o
end

function Side_Bar:draw()
    -- Draw the side bar on the top right corner
    rectfill(128 - self.width, 0, 128 - self.width, self.height, self.color)
    rectfill(128, 0, 128 - self.width + 1, self.height, self.sub_color)

    -- Formula: screen_width - index * (sprite_width + sprite_spacing) - sprite_width - padding
    print("skills", 129 - self.width + 6/2, 18, 7)

    -- circ(129 - self.width + 6/2 + 2, 18 + 11 + 4, 8, 7)
    -- spr(11, 129 - self.width + 2, 18 + 11)
end