push = require 'push' -- https://github.com/Ulydev/push
Class = require 'class' -- https://github.com/vrld/hump/blob/master/class.lua

local windowWidth, windowHeight = love.window.getDesktopDimensions()
local windowWidth, windowHeight = windowWidth * 0.6, windowHeight * 0.6

G_VIRTUAL_WIDTH = 512
G_VIRTUAL_HEIGHT = 288

require 'StateMachine'
require 'states/BaseState'
require 'states/PlayState'
require 'states/TitleScreenState'

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    love.window.setTitle('Floppy Bird')
    math.randomseed(os.time())

    gSounds = {
        ['score'] = love.audio.newSource('assets/score.wav', 'static')
    }

    gSmallFont = love.graphics.newFont('assets/font.ttf', G_VIRTUAL_WIDTH * 0.06)
    gMediumFont = love.graphics.newFont('assets/font.ttf', G_VIRTUAL_WIDTH * 0.08)
    gFlappyFont = love.graphics.newFont('assets/font.ttf', G_VIRTUAL_WIDTH * 0.10)
    gHugeFont = love.graphics.newFont('assets/font.ttf', G_VIRTUAL_WIDTH * 0.12)
    love.graphics.setFont(gFlappyFont)

    gStateMachine =
        StateMachine {
        ['title'] = function() return TitleScreenState() end,
        ['play'] = function() return PlayState() end
    }
    gStateMachine:change('title')

    push:setupScreen(
        G_VIRTUAL_WIDTH,
        G_VIRTUAL_HEIGHT,
        windowWidth,
        windowHeight,
        {
            fullscreen = false,
            resizable = true,
            vsync = true,
            pixelperfect = true
        }
    )
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.update(dt)
    gStateMachine:update(dt)
end

function love.keypressed(key)
    gStateMachine:keyPressed(key)
end

function love.draw()
    love.graphics.clear(0, 0, 0)
    push:apply('start')
    gStateMachine:render()
    push:apply('end')
end
