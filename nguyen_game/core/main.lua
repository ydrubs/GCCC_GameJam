function _init()
    game_manager = Game_Manager:new()
    game_manager:init()
    hud = HUD:new()
end

function _update()
    game_manager:update()
end

function _draw()
    cls()
    hud:draw()
    game_manager:draw()
end