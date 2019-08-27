TitleScreenState = Class{__includes = BaseState}

function TitleScreenState:keyPressed(key)
    if key == 'enter' or key == 'return' then
        gStateMachine:change('countdown')
    elseif key == 'escape' then
        love.event.quit()
    end
end

function TitleScreenState:render()
    local y = G_VIRTUAL_HEIGHT * 0.05
    love.graphics.setColor(0.5, 0.5, 0.5, 0.7)
    love.graphics.setFont(gFlappyFont)
    love.graphics.printf('Floppy Bird', 0, y, G_VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(1, 1, 1, 0.8)
    love.graphics.printf('Floppy Bird', 0, y - 5, G_VIRTUAL_WIDTH, 'center')

    local y2 = G_VIRTUAL_HEIGHT * 0.6
    love.graphics.setColor(0.5, 0.5, 0.5, 0.5)
    love.graphics.rectangle('fill', 0, y2, G_VIRTUAL_WIDTH, 28)

    love.graphics.setColor(1, 1, 1, 0.8)
    love.graphics.setFont(gMediumFont)
    love.graphics.printf('Press Enter', 0, y2, G_VIRTUAL_WIDTH, 'center')
end
