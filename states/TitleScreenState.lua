TitleScreenState = Class{__includes = BaseState}

function TitleScreenState:keyPressed(key)
    if key == 'enter' or key == 'return' then
        gStateMachine:change('countdown')
    elseif key == 'escape' then
        love.event.quit()
    end
end

function TitleScreenState:render()
    love.graphics.setFont(gFlappyFont)
    love.graphics.printf('Floppy Bird', 0, G_VIRTUAL_HEIGHT * 0.05, G_VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(gMediumFont)
    love.graphics.printf('Press Enter', 0, G_VIRTUAL_HEIGHT * 0.6, G_VIRTUAL_WIDTH, 'center')
end
