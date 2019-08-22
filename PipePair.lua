require 'Pipe'

PipePair = Class{}

local HEIGHT_DIFF = 0
local MIN_GAP_EACH_WAY = 40

-- TODO init from a PipePair
-- TODO guarantee that top pipe has a min height
-- TODO guarantee that bottom pipe has a min height

function PipePair:init(sprite, gapStart, gapEnd, scrollSpeed)
    self.scrollSpeed = scrollSpeed

    local height = sprite:getHeight()
    local x = virtualWidth + sprite:getWidth()
    local topTubeY = gapStart
    local bottomTubeY = gapEnd

    self.topPipe = Pipe(sprite, x, topTubeY, scrollSpeed)
    self.bottomPipe = Pipe(sprite, x, bottomTubeY, scrollSpeed)
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