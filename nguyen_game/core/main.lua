function _init()
    hud = HUD:new()
    player = Player:new{x = 47-8, y = 100}
end

function _update()
    player:update() -- Update player position based on input
end

function _draw()
    cls()
    hud:draw()
    player:draw() -- Draw the player sprite
end