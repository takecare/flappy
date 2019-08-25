Pipe = Class{}

function Pipe:init(sprite, topOrBottom, x, y, scrollSpeed)
    self.sprite = sprite
    self.x = x
    self.y = y
    self.width = sprite:getWidth()
    self.height = sprite:getHeight()
    self.scrollSpeed = scrollSpeed
    self.isTop = topOrBottom == 'top'
end

function Pipe:update(dt)
    self.x = self.x + self.scrollSpeed * dt
end

function Pipe:render()
    if self.isTop then
        self:renderAsTop()
    else
        self:renderAsBottom()
    end
end

function renderBoundingBox()
    local r, g, b, a = love.graphics.getColor()
    love.graphics.setColor(1, 1, 1, 0.5)
    love.graphics.rectangle('fill', self:boundingBox().x, self:boundingBox().y, self:boundingBox().width, self:boundingBox().height)
    love.graphics.setColor(r, g, b, a)
end

function Pipe:renderAsTop()
    love.graphics.draw(
        self.sprite,
        self.x,
        self.y - self.height,
        math.rad(180),
        1,
        1,
        self.width,
        self.height
    )
end

function Pipe:renderAsBottom()
    love.graphics.draw(
        self.sprite,
        self.x,
        G_VIRTUAL_HEIGHT + -1 * self.y,
        0,
        1,
        1,
        0,
        0
    )
end

function Pipe:isPastScreen()
    return self.x < -self.width
end

function Pipe:boundingBox()
    local y = self.isTop and self.y - self.height or G_VIRTUAL_HEIGHT + -1 * self.y
    return {
        x = self.x + 2,
        y = y + 2,
        width = self.width - 4,
        height = self.height - 4,
    }
end

function Pipe:collidesWith(box)
    local myBox = self:boundingBox()
    return myBox.x < box.x + box.width and myBox.x + myBox.width > box.x
        and myBox.y < box.y + box.height and myBox.y + myBox.height > box.y
end
