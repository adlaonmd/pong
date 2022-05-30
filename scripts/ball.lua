local Ball = {}

local round_winner = 0

local sounds = {}
sounds.blip = love.audio.newSource("sounds/menu_press.wav", "static")
sounds.wallHit = love.audio.newSource("sounds/wall_hit.wav", "static")
sounds.paddleHit = love.audio.newSource("sounds/paddle_hit.wav", "static")
sounds.scored = love.audio.newSource("sounds/score.wav", "static")
sounds.matchPoint = love.audio.newSource("sounds/match_point.mp3", "static")
sounds.suddenDeath = love.audio.newSource("sounds/sudden_death.mp3", "static")

function Ball:load()
    self:resetBall()
    self.width = BALL_SIZE
    self.height = BALL_SIZE
    self.speed = 400
    self.dirX = 0
    self.dirY = 0
    self.active = false

    round_winner = 0
end

function Ball:update(dt)
    if self.active then
        self:moveBall(dt)

        self:checkWallCollisions()
    end
end

function Ball:draw()
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

function Ball:keypressed(key)
    if key == "return" and not self.active then
        sounds.blip:play()
        self.active = true
        self:playBall(round_winner)
    end
end

function Ball:resetBall()
    self.speed = 400
    self.active = false
    self.x = SCREEN_WIDTH / 2 - BALL_SIZE / 2
    self.y = SCREEN_HEIGHT / 2 - BALL_SIZE / 2
end

function Ball:playBall(play_ball)
    local play_ball = play_ball or 0

    -- local randY = love.math.random(-1, 1)
    -- while randY == 0 do
    --     randY = love.math.random(-1, 1)
    -- end

    if play_ball == 0 then
        local randX = love.math.random(-1, 1)

        while randX == 0 do
            randX = love.math.random(-1, 1)
        end


        self.dirX = randX
    elseif play_ball == 1 then
        self.dirX = 1
    elseif play_ball == 2 then
        self.dirX = -1
    end

    self.dirY = 0
end

function Ball:moveBall(dt)
    local length = math.sqrt(self.dirX ^ 2 + self.dirY ^ 2)
    self.dirX, self.dirY = self.dirX / length, self.dirY / length

    self.x = self.x + self.dirX * self.speed * dt
    self.y = self.y + self.dirY * self.speed * dt
end

function Ball:checkWallCollisions()
    --TOP AND BOTTOM WALL COLLISION
    if self.y < 0 then
        sounds.wallHit:play()
        self.y = 0
        self.dirY = self.dirY * -1
    elseif self.y + self.height > SCREEN_HEIGHT then
        sounds.wallHit:play()
        self.y = SCREEN_HEIGHT - self.height
        self.dirY = self.dirY * -1
    end

    --LEFT AND RIGHT WALL COLLISION
    self:playerScored()
end

function Ball:playerScored()
    if self.x < 0 then
        sounds.scored:play()
        round_winner = 2
        Player2Score = Player2Score + 1
        self:matchPoint()
        self:suddenDeath()
        self:resetBall()
    elseif self.x + self.width > SCREEN_WIDTH then
        sounds.scored:play()
        round_winner = 1
        Player1Score = Player1Score + 1
        self:matchPoint()
        self:suddenDeath()
        self:resetBall()
    end
end

function Ball:suddenDeath()
    if Player1Score == WinningScore - 1 and Player2Score == WinningScore - 1 then
        sounds.suddenDeath:play()
    end
end

function Ball:matchPoint()
    if Player1Score == WinningScore - 1 and Player1Score > Player2Score then
        sounds.matchPoint:play()

    elseif Player2Score == WinningScore - 1 and Player2Score > Player1Score then
        sounds.matchPoint:play()
    end
end

function Ball:checkPaddleCollision(paddle)
    if self.x < paddle.x + paddle.width and self.x + self.width > paddle.x and self.y < paddle.y + paddle.height and self.y + self.height > paddle.y then
        sounds.paddleHit:play()
        self.speed = self.speed + 20
        self.dirX = self.dirX * -1

        local middle_paddle = paddle.y + paddle.height / 2
        local middle_ball = self.y + self.height / 2
        local velY = (middle_ball - middle_paddle) / (paddle.height / 2)
        self.dirY = velY
    end
end

return Ball
