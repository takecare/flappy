Player = Class{}

local GRAVITY = 20

function Player:init(x, y)
    self.sprite = love.graphics.newImage("assets/bird.png")
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
    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(self.sprite, self.x, self.y, 0, 1, 1, self.width, self.height)
end

--[[
    jumping:
    dt	g	dy	y
    ---------------
    .5	4	0	100
    .5	4	2	102
    .5	4	4	106
    .5	4	6	112
    .5	4	8	120
    .5	4	10	130
    .5	4	12	142
    .5	4	14	156
    .5	4	16	172
    .5	4	-10 162	<- player jumps
    .5	4	-8	154
    .5	4	-6	148
    .5	4	-4	144
    .5	4	-2	142
    .5	4	0	142
    .5	4	2	144
    .5	4	4	148
    .5	4	6	154
]]
function Player:keypressed(key)
    if key == "space" then
        self.dy = -10
    elseif key == "mouseLeftDown" then
        -- ...
    end
end