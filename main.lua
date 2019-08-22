push = require 'push' -- https://github.com/Ulydev/push
Class = require 'class' -- https://github.com/vrld/hump/blob/master/class.lua

require 'Player'
require 'PipePair'

windowWidth, windowHeight = love.window.getDesktopDimensions()
windowWidth, windowHeight = windowWidth * 0.6, windowHeight * 0.6

virtualWidth = 512
virtualHeight = 288

local player = Player(virtualWidth / 10, virtualHeight / 2)

local pipeSprite = love.graphics.newImage('assets/pipe.png')
local pipes = {}
local pipeSpawnTimer = 0

local lastGap = {
    top = virtualHeight / 2 - 40, 
    bottom = virtualHeight / 2 - 40
}

local background = love.graphics.newImage('assets/background.png')
local backgroundScroll = 0
local BACKGROUND_SCROLL_SPEED = 10
local BACKGROUND_LOOP_POINT = 413

local ground = love.graphics.newImage('assets/ground.png')
local groundScroll = 0
local GROUND_SCROLL_SPEED = 60

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')

    love.window.setTitle('bird')
    math.randomseed(os.time())

    font = love.graphics.newFont('assets/font.ttf', virtualWidth * 0.08)
    love.graphics.setFont(font)

    sounds = {
        ['score'] = love.audio.newSource('assets/score.wav', 'static'),
    }
 
    push:setupScreen(virtualWidth, virtualHeight, windowWidth, windowHeight, {
        fullscreen = false,
        resizable = true, 
        vsync = true,
        pixelperfect = true
    })
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.update(dt)
    pipeSpawnTimer = pipeSpawnTimer + dt
    if pipeSpawnTimer >= 2 then
        local pipe = PipePair(
            pipeSprite,
            lastGap.top,
            lastGap.bottom,
            -GROUND_SCROLL_SPEED
        )
        table.insert(pipes, pipe)
        
        -- pipes[table.getn(pipes)] -- last element in array
        local lastTop = lastGap.top
        local lastBottom = lastGap.bottom

        local delta = math.random() <= 0.5 and -50 or 50
        local topDelta = delta
        local bottomDelta = -delta

        local newTop = lastTop + topDelta
        local newBottom = lastBottom + bottomDelta

        if (newTop < 50 or newBottom < 50) then
            lastGap.top = lastTop
            lastGap.bottom = lastBottom
        else
            lastGap.top = newTop
            lastGap.bottom = newBottom
        end
        pipeSpawnTimer = 0
    end

    backgroundScroll = (backgroundScroll + BACKGROUND_SCROLL_SPEED * dt)
        % BACKGROUND_LOOP_POINT
    groundScroll = (groundScroll + GROUND_SCROLL_SPEED * dt)
        % virtualWidth

    player:update(dt)
    for k, pipe in pairs(pipes) do
        pipe:update(dt)
        if (pipe:isPastScreen()) then
            table.remove(pipes, k)
        end
    end
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    else
        player:keypressed(key)
    end
end
 
function love.draw()
    love.graphics.clear(0, 0, 0)
    push:apply("start")

    love.graphics.draw(background, -backgroundScroll, 0)

    for k, pipe in pairs(pipes) do
        pipe:render()
    end

    love.graphics.draw(ground, -groundScroll, virtualHeight - ground:getHeight())

    player:render()

    push:apply("end")
end
