Pipe = Class{}

function Pipe:init(sprite, x, y, scrollSpeed)
    self.sprite = sprite
    self.x = x ~= nil and x or virtualWidth + sprite:getWidth() * 2
    self.y = y ~= nil and y or math.random(virtualHeight / 4, virtualHeight - 10)
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
        self.x + self.width,
        self.y + self.height,
        math.rad(180),
        1,
        1,
        0,--self.width / 2,
        0--self.height / 2
    )
end

function Pipe:renderAsBottom()
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
end

function Pipe:isPastScreen()
    return self.x < -self.width
end