Player = Class{}

local GRAVITY = 13
local JUMP_SPEED = -5

function Player:init(x, y)
    self.sprite = love.graphics.newImage('assets/bird.png')
    self.x = x ~= nil and x or virtualWidth / 2
    self.y = y ~= nil and y or virtualHeight / 2
    self.dy = 0
    self.width = self.sprite:getWidth()
    self.height = self.sprite:getHeight()
end

function Player:update(dt)
    self.dy = self.dy + GRAVITY * dt
    self.y = self.y + self.dy
end

function Player:render()
    love.graphics.draw(
        self.sprite,
        self.x,
        self.y,
        0,
        1,
        1,
        0,
        0
    )

    love.graphics.rectangle('fill', self:boundingBox().x, self:boundingBox().y, self:boundingBox().width, self:boundingBox().height)
end

function Player:keypressed(key)
    if key == "space" then
        self.dy = JUMP_SPEED
    end
end

function Player:boundingBox()
    return {
        x = self.x + 2,
        y = self.y + 2,
        width = self.width - 4,
        height = self.height - 4,
    }
end
