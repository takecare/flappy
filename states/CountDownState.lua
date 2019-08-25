CountDownState = Class {__includes = BaseState}

local timer

function CountDownState:enter()
    timer = 4
end

function CountDownState:update(dt)
    if timer <= 0 then
        gStateMachine:change('play')
    else
        timer = timer - dt
    end
end

function CountDownState:render()
    local countdown = timer - timer % 1
    local toDisplay = countdown >= 0 and countdown or 0
    love.graphics.setFont(gMediumFont)
    love.graphics.printf(toDisplay, 0, G_VIRTUAL_HEIGHT / 2, G_VIRTUAL_WIDTH, 'center')
end
