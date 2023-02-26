local Concord = require("concord")
local fonts = require("fonts")

local FpsCounterSystem = Concord.system()

local fps

function FpsCounterSystem:update(dt)
	fps = 1 / dt
end

function FpsCounterSystem:draw()
	love.graphics.setFont(fonts.fps)
	love.graphics.setColor(0, 1, 0)
	love.graphics.print(tostring(math.floor(fps)), 30, 30)
end

return FpsCounterSystem
