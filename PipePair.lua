require 'Pipe'

PipePair = Class{}

local MIN_HORIZONTAL_GAP = 50
local EXTRA_GAP_SPACING = { 0, 5, 10, 15, 20, 25, 30, 35 }

--[[
    | | gapStart is measured    | |
    |_| from the top            | | <- in this pipe pair,
                                |-| gapStart = gapEnd = virtualHeight / 2
     _  gapEnd is measured      | |
    | | from the bottom         | |
    | |
]]

function PipePair:init(sprite, startX, gapStart, gapEnd, scrollSpeed) 
    self.scrollSpeed = scrollSpeed

    local height = sprite:getHeight()
    local extraSpacing = EXTRA_GAP_SPACING[math.random(1, table.getn(EXTRA_GAP_SPACING))]
    local pipeX = startX + sprite:getWidth() + extraSpacing + MIN_HORIZONTAL_GAP
    local topTubeY = gapStart
    local bottomTubeY = gapEnd

    self.startX = pipeX
    self.gapStart = topTubeY
    self.gapEnd = bottomTubeY
    self.topPipe = Pipe(sprite, 'top', pipeX, topTubeY, scrollSpeed)
    self.bottomPipe = Pipe(sprite, 'bottom', pipeX, bottomTubeY, scrollSpeed)
end

function PipePair:update(dt)
    self.topPipe:update(dt)
    self.bottomPipe:update(dt)
end

function PipePair:render()
    self.topPipe:render()
    self.bottomPipe:render()
end

function PipePair:isPastScreen()
    return self.topPipe:isPastScreen()
end

function PipePair:collidesWith(box)
    return self.topPipe:collidesWith(box) or self.bottomPipe:collidesWith(box)
end
