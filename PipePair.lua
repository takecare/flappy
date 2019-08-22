require 'Pipe'

PipePair = Class{}

local HEIGHT_DIFF = 0
local MIN_GAP_EACH_WAY = 40
local EXTRA_GAP_SPACING = { 0, 5, 10, 15, 20, 25, 30, 35 }

-- TODO init from a PipePair
-- TODO guarantee that top pipe has a min height
-- TODO guarantee that bottom pipe has a min height

function PipePair:init(sprite, gapStart, gapEnd, scrollSpeed)
    self.scrollSpeed = scrollSpeed

    local height = sprite:getHeight()
    local extraSpacing = EXTRA_GAP_SPACING[math.random(1, table.getn(EXTRA_GAP_SPACING))]
    local pipeX = virtualWidth + sprite:getWidth() + extraSpacing
    local topTubeY = gapStart
    local bottomTubeY = gapEnd

    self.topPipe = Pipe(sprite, pipeX, topTubeY, scrollSpeed)
    self.bottomPipe = Pipe(sprite, pipeX, bottomTubeY, scrollSpeed)
end

function PipePair:update(dt)
    self.topPipe:update(dt)
    self.bottomPipe:update(dt)
end

function PipePair:render()
    self.topPipe:renderAsTop()
    self.bottomPipe:renderAsBottom()
end

function PipePair:isPastScreen()
    return self.topPipe:isPastScreen()
end