local Game = {}

local screen_manager = require("screens.screen_manager")

local ball = require("scripts.ball")
local paddle = require("scripts.paddle")

local player1 = paddle:new()
local player2 = paddle:new()

local scoreFont = love.graphics.newFont(64)

local player1ScoreTextWidth = 0
local player2ScoreTextWidth = 0

function Game:load()
    Player1Score = 0
    Player2Score = 0

    ball:load()
    player1:load(PADDLE_WIDTH * 3, SCREEN_HEIGHT / 2 - PADDLE_HEIGHT / 2)
    player2:load(SCREEN_WIDTH - PADDLE_WIDTH * 4, SCREEN_HEIGHT / 2 - PADDLE_HEIGHT / 2)
end

function Game:update(dt)
    player1ScoreTextWidth = scoreFont:getWidth(Player1Score)
    player2ScoreTextWidth = scoreFont:getWidth(Player2Score)

    ball:update(dt)
    player1:update(dt)
    player2:update(dt)

    ball:checkPaddleCollision(player1)
    ball:checkPaddleCollision(player2)

    self:checkWinner()
end

function Game:draw()
    love.graphics.setFont(scoreFont)
    love.graphics.print(Player1Score, SCREEN_WIDTH / 4 - player1ScoreTextWidth / 2, 0)
    love.graphics.print(Player2Score, (SCREEN_WIDTH - (SCREEN_WIDTH / 4)) - player2ScoreTextWidth / 2, 0)

    ball:draw()
    player1:draw()
    player2:draw()
end

function Game:keypressed(key)
    if ball.keypressed then ball:keypressed(key) end
end

function Game:checkWinner()
    if Player1Score >= WinningScore or Player2Score >= WinningScore then
        if Player1Score >= WinningScore then
            Winner = "Player 1 win!"
        else
            Winner = "Player 2 win!"
        end

        screen_manager:changeScreen("end")
    end
end

--Override default paddle controls
function player2:getInput()
    if love.keyboard.isDown("up") then
        self.dirY = -1
    elseif love.keyboard.isDown("down") then
        self.dirY = 1
    else
        self.dirY = 0
    end
end

return Game
