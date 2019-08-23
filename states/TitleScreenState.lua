TitleScreenState = Class{__includes = BaseState}

function TitleScreenState:keyPressed(key)
    if key == 'enter' or key == 'return' then
        gStateMachine:change('play')
    elseif key == 'escape' then
        love.event.quit()
    end
end

function TitleScreenState:render()
    love.graphics.setFont(gFlappyFont)
    love.graphics.printf('Floppy Bird', 0, 64, G_VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(gMediumFont)
    love.graphics.printf('Press Enter', 0, 100, G_VIRTUAL_WIDTH, 'center')
end
