Player = Class{}

function Player:init(x, y)
    self.sprite = love.graphics.newImage("assets/bird.png")
    self.x = x ~= nil and x or virtualWidth / 2
    self.y = y ~= nil and y or virtualHeight / 2
    self.width = self.sprite:getWidth()
    self.height = self.sprite:getHeight()
end

function Player:update(dt)
    -- ...
end

function Player:render()
    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(self.sprite, self.x, self.y, 0, 1, 1, self.width, self.height)
end

function Player:handleInput()
    if love.keyboard.isDown("w") then
        -- ...
    elseif love.keyboard.isDown("s") then
        -- ...
    else
        -- ...
    end

    if love.mouse.isDown(1) then
        -- ...
    end
end