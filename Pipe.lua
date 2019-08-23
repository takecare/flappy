Pipe = Class{}

function Pipe:init(sprite, x, y, scrollSpeed)
    self.sprite = sprite
    self.x = x
    self.y = y
    self.width = sprite:getWidth()
    self.height = sprite:getHeight()
    self.scrollSpeed = scrollSpeed
end

function Pipe:update(dt)
    self.x = self.x + self.scrollSpeed * dt
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
        virtualHeight + -1 * self.y,
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
