require 'Pipe'

PipePair = Class{}

local HEIGHT_DIFF = 10
local MIN_GAP = 20

function PipePair:init(sprite, lastY, scrollSpeed)
    self.scrollSpeed = scrollSpeed

    local randomSign = math.random() >= 0.5 and 1 or -1
    local height = sprite:getHeight()

    local x = virtualWidth + sprite:getWidth()
    local y = lastY - height -- need to subtract height due to the rotation
    local topY = y + HEIGHT_DIFF * randomSign
    local bottomY = topY + height + HEIGHT_DIFF * (randomSign * -1)

    self.topPipe = Pipe(sprite, x, topY, scrollSpeed)
    self.bottomPipe = Pipe(sprite, x, bottomY, scrollSpeed)
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