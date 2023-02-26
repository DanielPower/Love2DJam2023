local Concord = require("concord")
local fonts = require("fonts")

local MessageSystem = Concord.system()

function MessageSystem:draw()
	local world = self:getWorld()
	local message = world:getResource("message")
	if message then
		love.graphics.setColor(0, 0, 0, 0.5)
		love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
		love.graphics.setFont(fonts.levelMessage)
		love.graphics.setColor(1, 1, 1, 1)
		love.graphics.printf(
			message,
			0,
			(love.graphics.getHeight() - fonts.levelMessage:getHeight()) / 2,
			love.graphics.getWidth(),
			"center"
		)
	end
end

return MessageSystem
