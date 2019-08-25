PlayState = Class{__includes = BaseState}

require 'Player'
require 'PipePair'

local player

local pipeSprite
local pipes
local pipeSpawnTimer

local GAP_DELTAS = {0, 10, 20, 30, 40, 50}
local lastGap = {
    top = G_VIRTUAL_HEIGHT / 2 - GAP_DELTAS[6],
    bottom = G_VIRTUAL_HEIGHT / 2 - GAP_DELTAS[6]
}

function PlayState:init(scrollSpeed, topLimit, bottomLimit)
    self.scrollSpeed = scrollSpeed
    self.topLimit = topLimit
    self.bottomLimit = bottomLimit
    self.score = 0
end

function PlayState:enter() 
    pipeSprite = love.graphics.newImage('assets/pipe.png')

    player = Player(G_VIRTUAL_WIDTH / 10, G_VIRTUAL_HEIGHT / 2)
    self.score = 0

    pipes = {}
    pipeSpawnTimer = 0
    for i = 0,5 do
        self:addPipe(G_VIRTUAL_WIDTH + 200 * i)
    end
end

function PlayState:exit()
    pipes = {}
    background = nil
    ground = nil
    pipeSprite = nil
end

function PlayState:update(dt)
    pipeSpawnTimer = pipeSpawnTimer + dt
    if pipeSpawnTimer >= 2 then
        self:addPipe()
        pipeSpawnTimer = 0
    end

    player:update(dt)

    if player.y < self.topLimit or player.y > self.bottomLimit then
        self:collisionOccurred()
    end

    for k, pipe in pairs(pipes) do
        pipe:update(dt)
        if (pipe:collidesWith(player:boundingBox())) then
            self:collisionOccurred()
        end
    end

    for k, pipe in pairs(pipes) do
        if (pipe:isNotScored() and player:isPast(pipe:boundingBox())) then
            pipe:markAsScored()
            self.score = self.score + 1
        elseif (pipe:isPastScreen()) then
            table.remove(pipes, k)
            -- self:addPipe() -- TODO fix this bug
        end
    end
end

function PlayState:collisionOccurred()
    gSounds['collision']:play()
    gStateMachine:change('score', { score = self.score })
end

function PlayState:keyPressed(key)
    if key == 'space' then
        player:keypressed(key)
    elseif key == 'escape' then
        gStateMachine:change('title')
    end
end

function PlayState:render()
    for k, pipe in pairs(pipes) do
        pipe:render()
    end

    player:render()

    self:renderScore()
end

function PlayState:renderScore()
    love.graphics.setFont(gMediumFont)
    love.graphics.printf(self.score, 0, 10, G_VIRTUAL_WIDTH, 'center')
end

function PlayState:addPipe(startX)
    local x = startX ~= nil and startX or pipes[table.getn(pipes)].startX
    local lastTop = lastGap.top
    local lastBottom = lastGap.bottom

    local pipe = PipePair(pipeSprite, x, lastTop, lastBottom, -self.scrollSpeed)
    table.insert(pipes, pipe)

    local gap = GAP_DELTAS[math.random(1, table.getn(GAP_DELTAS))]
    -- move gap upwards or downwards
    local delta = math.random() <= 0.5 and -gap or gap
    local newTop = lastTop + delta
    local newBottom = lastBottom - delta

    -- ensure gap does not go over thresholds
    if (newTop < 40 or newBottom < 40) then
        lastGap.top = lastTop
        lastGap.bottom = lastBottom
    else
        lastGap.top = newTop
        lastGap.bottom = newBottom
    end
end

