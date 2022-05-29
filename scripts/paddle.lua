local Paddle = {}
Paddle.__index = Paddle

function Paddle:new()
    local instance = setmetatable({}, Paddle)
    return instance
end

function Paddle:load(x, y)
    self.x = x
    self.y = y
    self.width = PADDLE_WIDTH
    self.height = PADDLE_HEIGHT
    self.speed = 400
    self.dirY = 0
end

function Paddle:update(dt)
    self:getInput()
    self:movePaddle(dt)
    self:checkWallCollisions()
end

function Paddle:draw()
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

function Paddle:getInput()
    if love.keyboard.isDown("w") then
        self.dirY = -1
    elseif love.keyboard.isDown("s") then
        self.dirY = 1
    else
        self.dirY = 0
    end
end

function Paddle:movePaddle(dt)
    if self.dirY ~= 0 then
        local length = math.sqrt(self.dirY ^ 2)
        self.dirY = self.dirY / length

        self.y = self.y + self.dirY * self.speed * dt
    end
end

function Paddle:checkWallCollisions()
    if self.y < 0 then
        self.y = 0
    elseif self.y + self.height > SCREEN_HEIGHT then
        self.y = SCREEN_HEIGHT - self.height
    end
end

return Paddle
