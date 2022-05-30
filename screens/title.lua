local Title = {}

local screen_manager = require("screens.screen_manager")

local titleText = "Pong"
local playText = "Press 'ENTER' to play"

local titleFont = love.graphics.newFont(64)
local playFont = love.graphics.newFont(24)

local titleTextWidth = titleFont:getWidth(titleText)
local titleTextHeight = titleFont:getHeight()
local playTextWidth = playFont:getWidth(playText)
local playTextHeight = playFont:getHeight()

local sounds = {}
sounds.blip = love.audio.newSource("sounds/menu_press.wav", "static")
sounds.bgm = love.audio.newSource("sounds/title_bgm.mp3", "stream")
sounds.bgm:setLooping(true)

function Title:load()
    sounds.bgm:setVolume(0.5)
    sounds.bgm:play()
end

function Title:update(dt)

end

function Title:draw()
    love.graphics.setFont(titleFont)
    love.graphics.print(titleText, SCREEN_WIDTH / 2 - titleTextWidth / 2, SCREEN_HEIGHT / 2 - titleTextHeight)
    love.graphics.setFont(playFont)
    love.graphics.print(playText, SCREEN_WIDTH / 2 - playTextWidth / 2, SCREEN_HEIGHT / 2 + playTextHeight / 2)
end

function Title:keypressed(key)
    if key == "return" then
        sounds.blip:play()
        sounds.bgm:stop()
        screen_manager:changeScreen("game")
    end
end

return Title
