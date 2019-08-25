CountDownState = Class {__includes = BaseState}

local timer

function CountDownState:enter()
    timer = 3
end

function CountDownState:update(dt)
    if timer <= 0 then
        gStateMachine:change('play')
    else
        timer = timer - dt
    end
end

function CountDownState:render()
    local countdown = math.ceil(timer)
    local toDisplay = countdown >= 1 and countdown or 1
    love.graphics.setFont(gMediumFont)
    love.graphics.printf(toDisplay, 0, G_VIRTUAL_HEIGHT / 2, G_VIRTUAL_WIDTH, 'center')
end
