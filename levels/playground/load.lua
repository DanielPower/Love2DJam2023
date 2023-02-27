local Concord = require("concord")
local systems = require("systems")

return function(world)
	world:addSystems(unpack(systems.default))
	world:addSystem(systems.message)
	world:getSystem(systems.shoot):setEnabled(false)
	world:setResource("message", "You've learned well. Now go forth and grow")
	Concord.entity(world):give("timer", 3, function(entity)
		world:setResource("message", nil)
		world:getSystem(systems.shoot):setEnabled(true)
		world:addSystem(systems.goal)
		world:setResource("goal", {
			title = "Grow to 1 milligram",
			condition = function()
				local player = world:getResource("player")
				return player.mass.val >= 1000000000
			end,
		})
		entity:destroy()
	end)
end
