push = require 'push' -- https://github.com/Ulydev/push
Class = require 'class' -- https://github.com/vrld/hump/blob/master/class.lua

local windowWidth, windowHeight = love.window.getDesktopDimensions()
local windowWidth, windowHeight = windowWidth * 0.6, windowHeight * 0.6

G_VIRTUAL_WIDTH = 512
G_VIRTUAL_HEIGHT = 288

require 'StateMachine'
require 'states/BaseState'
require 'states/TitleScreenState'
require 'states/CountDownState'
require 'states/PlayState'
require 'states/ScoreState'

local background
local backgroundScroll = 0
local BACKGROUND_SCROLL_SPEED = 10
local BACKGROUND_LOOP_POINT = 568

local ground
local groundScroll = 0
local GROUND_SCROLL_SPEED = 10 * 6

function love.load()
    if arg[#arg] == "-debug" then require("mobdebug").start() end -- enable zerobrane debugging
  
    love.graphics.setDefaultFilter('nearest', 'nearest')
    love.window.setTitle('Floppy Bird')
    math.randomseed(os.time())

    background = love.graphics.newImage('assets/background.png')
    ground = love.graphics.newImage('assets/ground.png')

    gSounds = {
        ['music'] = love.audio.newSource('assets/bgmusic.wav', 'static'),
        ['hurt'] = love.audio.newSource('assets/hurt.wav', 'static'),
        ['jump'] = love.audio.newSource('assets/jump.wav', 'static'),
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
        ['countdown'] = function() return CountDownState() end,
        ['play'] = function() 
            local playState = PlayState(
                GROUND_SCROLL_SPEED,
                0,
                G_VIRTUAL_HEIGHT - ground:getHeight()
            )
            return playState
        end,
        ['score'] = function() return ScoreState() end
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

    gSounds['music']:setLooping(true)
    gSounds['music']:play()
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.update(dt)
    backgroundScroll = (backgroundScroll + BACKGROUND_SCROLL_SPEED * dt) % BACKGROUND_LOOP_POINT
    groundScroll = (groundScroll + GROUND_SCROLL_SPEED * dt) % G_VIRTUAL_WIDTH

    gStateMachine:update(dt)
end

function love.keypressed(key)
    gStateMachine:keyPressed(key)
end

function love.draw()
    love.graphics.clear(0, 0, 0)
    push:apply('start')

    love.graphics.draw(background, -backgroundScroll, 0)
    gStateMachine:render()
    love.graphics.draw(ground, -groundScroll, G_VIRTUAL_HEIGHT - ground:getHeight())

    push:apply('end')
end
