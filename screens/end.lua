local End = {}

local screen_manager = require("screens.screen_manager")

local PlayAgainText = "Press 'ENTER' to play again"

local winnerFont = love.graphics.newFont(48)
local playAgainFont = love.graphics.newFont(24)

local winnerTextWidth = 0
local winnerTextHeight = winnerFont:getHeight()
local playAgainTextWidth = playAgainFont:getWidth(PlayAgainText)
local playAgainTextHeight = playAgainFont:getHeight()

local sounds = {}
sounds.bgm = love.audio.newSource("sounds/end_bgm.mp3", "stream")
sounds.bgm:setLooping(true)

function End:load()
    sounds.bgm:play()
end

function End:update(dt)
    winnerTextWidth = winnerFont:getWidth(Winner)
end

function End:draw()
    love.graphics.setFont(winnerFont)
    love.graphics.print(Winner, SCREEN_WIDTH / 2 - winnerTextWidth / 2, SCREEN_HEIGHT / 2 - winnerTextHeight)
    love.graphics.setFont(playAgainFont)
    love.graphics.print(PlayAgainText, SCREEN_WIDTH / 2 - playAgainTextWidth / 2, SCREEN_HEIGHT / 2 + playAgainTextHeight / 2)
end

function End:keypressed(key)
    if key == "escape" then
        sounds.bgm:stop()
        screen_manager:changeScreen("title")
    elseif key == "return" then
        sounds.bgm:stop()
        screen_manager:changeScreen("game")
    end
end

return End
