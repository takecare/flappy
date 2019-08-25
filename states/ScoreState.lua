ScoreState = Class{__includes = BaseState}

function ScoreState:init()
    self.score = 0
end

function ScoreState:keyPressed(key)
    if key == 'enter' or key == 'return' then
        gStateMachine:change('play')
    elseif key == 'escape' then
        gStateMachine:change('title')
    end
end

function ScoreState:enter(params)
    self.score = params.score
end

function ScoreState:render()
    love.graphics.setFont(gFlappyFont)
    love.graphics.printf(self.score, 0, G_VIRTUAL_HEIGHT * 0.1, G_VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(gMediumFont)
    love.graphics.printf('Press Enter to try again', 0, G_VIRTUAL_HEIGHT * 0.4, G_VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(gSmallFont)
    love.graphics.printf('Press Escape to quit', 0, G_VIRTUAL_HEIGHT * 0.7, G_VIRTUAL_WIDTH, 'center')
end
