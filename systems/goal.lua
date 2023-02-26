local Concord = require("concord")

local GoalSystem = Concord.system()

function GoalSystem:update()
	local world = self:getWorld()
	local goal = world:getResource("goal")
	if goal.condition() then
		print("win")
	end
end

function GoalSystem:draw() end

return GoalSystem
