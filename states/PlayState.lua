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

local background
local backgroundScroll = 0
local BACKGROUND_SCROLL_SPEED = 10
local BACKGROUND_LOOP_POINT = 413

local ground
local groundScroll = 0
local GROUND_SCROLL_SPEED = 10 * 6

function PlayState:init() 
    --
end

function PlayState:enter() 
    background = love.graphics.newImage('assets/background.png')
    ground = love.graphics.newImage('assets/ground.png')
    pipeSprite = love.graphics.newImage('assets/pipe.png')

    player = Player(G_VIRTUAL_WIDTH / 10, G_VIRTUAL_HEIGHT / 2)

    pipes = {}
    pipeSpawnTimer = 0
    for i = 0,5 do
        addPipe(G_VIRTUAL_WIDTH + 200 * i)
    end
end

function PlayState:exit()
    pipes = {}
    player = nil
    background = nil
    ground = nil
    pipeSprite = nil
end

function PlayState:update(dt)
    backgroundScroll = (backgroundScroll + BACKGROUND_SCROLL_SPEED * dt) % BACKGROUND_LOOP_POINT
    groundScroll = (groundScroll + GROUND_SCROLL_SPEED * dt) % G_VIRTUAL_WIDTH

    pipeSpawnTimer = pipeSpawnTimer + dt
    if pipeSpawnTimer >= 2 then
        addPipe()
        pipeSpawnTimer = 0
    end

    player:update(dt)
    for k, pipe in pairs(pipes) do
        pipe:update(dt)
        if (pipe:collidesWith(player:boundingBox())) then
            gSounds['score']:play()
        end
    end

    for k, pipe in pairs(pipes) do
        if (pipe:isPastScreen()) then
            table.remove(pipes, k)
        -- addPipe() -- TODO fix this bug
        end
    end
end

function PlayState:keyPressed(key)
    if key == 'space' then
        player:keypressed(key)
    elseif key == 'escape' then
        gStateMachine:change('title')
    end
end

function PlayState:render()
    love.graphics.draw(background, -backgroundScroll, 0)

    for k, pipe in pairs(pipes) do
        pipe:render()
    end

    love.graphics.draw(ground, -groundScroll, G_VIRTUAL_HEIGHT - ground:getHeight())

    player:render()
end

function addPipe(startX)
    local x = startX ~= nil and startX or pipes[table.getn(pipes)].startX
    local lastTop = lastGap.top
    local lastBottom = lastGap.bottom

    local pipe = PipePair(pipeSprite, x, lastTop, lastBottom, -GROUND_SCROLL_SPEED)
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

