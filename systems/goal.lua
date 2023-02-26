local Concord = require("concord")
local fonts = require("fonts")
local worldManager = require("world")

local GoalSystem = Concord.system()

function GoalSystem:goalComplete()
	self:getWorld():setResource("message", "Level complete. Press Enter to continue")
end

function GoalSystem:keypressed(key)
	if key == "return" and self:getWorld():getResource("goal").condition() then
		worldManager.nextMap()
	end
end

function GoalSystem:update()
	local world = self:getWorld()
	local goal = world:getResource("goal")
	if goal and goal.condition() then
		world:emit("goalComplete")
	end
end

function GoalSystem:draw()
	local world = self:getWorld()
	local goal = world:getResource("goal")
	if goal then
		love.graphics.setFont(fonts.hud)
		if goal.condition() then
			love.graphics.setColor(0, 1, 0)
		else
			love.graphics.setColor(1, 1, 1)
		end
		love.graphics.printf("Goal: " .. goal.title, 0, 10, love.graphics.getWidth() - 10, "right")
	end
end

return GoalSystem
