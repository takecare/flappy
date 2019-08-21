push = require 'push' -- https://github.com/Ulydev/push
Class = require 'class' -- https://github.com/vrld/hump/blob/master/class.lua

require 'Player'

windowWidth, windowHeight = love.window.getDesktopDimensions()
windowWidth, windowHeight = windowWidth * 0.6, windowHeight * 0.6

virtualWidth = 512
virtualHeight = 288

local player = Player(virtualWidth / 10, virtualHeight / 2)

local background = love.graphics.newImage('assets/background.png')
local backgroundScroll = 0
local BACKGROUND_SCROLL_SPEED = 10
local BACKGROUND_LOOP_POINT = 413

local ground = love.graphics.newImage('assets/ground.png')
local groundScroll = 0
local GROUND_SCROLL_SPEED = 30

function love.load()
    -- set love's default filter to "nearest-neighbor", which essentially
    -- means there will be no filtering of pixels (blurriness), which is
    -- important for a nice crisp, 2D look
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

    -- ...
end

function love.resize(w, h)
    push:resize(w, h)
end

--[[
    Called every frame, passing in `dt` since the last frame. `dt`
    is short for `deltaTime` and is measured in seconds. Multiplying
    this by any changes we wish to make in our game will allow our
    game to perform consistently across all hardware; otherwise, any
    changes we make will be applied as fast as possible and will vary
    across system hardware.
]]
function love.update(dt)
    backgroundScroll = (backgroundScroll + BACKGROUND_SCROLL_SPEED * dt)
        % BACKGROUND_LOOP_POINT
    groundScroll = groundScroll + GROUND_SCROLL_SPEED * dt
        % virtualWidth
end

--[[
    A callback that processes key strokes as they happen, just the once.
    Does not account for keys that are held down, which is handled by a
    separate function (`love.keyboard.isDown`). Useful for when we want
    things to happen right away, just once, like when we want to quit.
]]
function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    else
        sounds['score']:play()
    end
end

function love.draw()
    love.graphics.clear(0, 0, 0)
    push:apply("start")

    love.graphics.draw(background, -backgroundScroll, 0)
    love.graphics.draw(ground, -groundScroll, virtualHeight - ground:getHeight())

    player:render()

    push:apply("end")
end
