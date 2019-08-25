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
    local rotation = self.dy < 0 and math.rad(-2) or math.rad(2)

    love.graphics.draw(
        self.sprite,
        self.x,
        self.y,
        rotation,
        1,
        1,
        self.width/2,
        self.height/2
    )

    -- self:renderBoundingBox()
end

function Player:renderBoundingBox()
    local r, g, b, a = love.graphics.getColor()
    love.graphics.setColor(1, 1, 1, 0.5)
    love.graphics.rectangle('fill', self:boundingBox().x, self:boundingBox().y, self:boundingBox().width, self:boundingBox().height)
    love.graphics.setColor(r, g, b, a)
end

function Player:keypressed(key)
    if key == "space" then
        self:jump()
    end
end

function Player:jump()
    self.dy = JUMP_SPEED
    gSounds['jump']:play()
end

function Player:boundingBox()
    return { -- width/2 & height/2 to account for the offset of rotation
        x = self.x - self.width / 2 + 2,
        y = self.y - self.height / 2 + 2,
        width = self.width - 4,
        height = self.height - 4,
    }
end

function Player:isPast(box)
    return self.x > box.x + box.width
end
