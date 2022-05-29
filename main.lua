require("globals")

love.window.setTitle("Pong")
love.window.setMode(SCREEN_WIDTH, SCREEN_HEIGHT, {})

local screen_manager = require("screens.screen_manager")

function love.load()
    screen_manager:load()
end

function love.update(dt)
    screen_manager:update(dt)
end

function love.draw()
    screen_manager:draw()
end

function love.keypressed(key)
    if key == "escape" then
        screen_manager:changeScreen("title")
    elseif key == "f5" then
        love.event.quit("restart")
    end

    if screen_manager.keypressed then screen_manager:keypressed(key) end
end
