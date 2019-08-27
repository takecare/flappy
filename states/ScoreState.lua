ScoreState = Class{__includes = BaseState}

function ScoreState:init()
    self.score = 0
end

function ScoreState:keyPressed(key)
    if key == 'enter' or key == 'return' then
        gStateMachine:change('countdown')
    elseif key == 'escape' then
        gStateMachine:change('title')
    end
end

function ScoreState:enter(params)
    self.score = params.score
end

function ScoreState:render()
    local y = G_VIRTUAL_HEIGHT * 0.1
    love.graphics.setColor(0.5, 0.5, 0.5, 0.7)
    love.graphics.setFont(gFlappyFont)
    love.graphics.printf('oops!', 0, y, G_VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(1, 1, 1, 0.8)
    love.graphics.printf('oops!', 0, y - 5, G_VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(gHugeFont)
    love.graphics.printf('final score: ' .. self.score, 0, G_VIRTUAL_HEIGHT * 0.3, G_VIRTUAL_WIDTH, 'center')

    local y3 =  G_VIRTUAL_HEIGHT * 0.65
    love.graphics.setFont(gSmallFont)
    love.graphics.setColor(0.5, 0.5, 0.5, 0.5)
    love.graphics.rectangle('fill', 0, y3, G_VIRTUAL_WIDTH, 42)
    love.graphics.setColor(1, 1, 1, 0.8)
    love.graphics.printf('enter to try again\nescape to quit', 0, y3, G_VIRTUAL_WIDTH, 'center')
end
