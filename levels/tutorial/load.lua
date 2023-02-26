local Concord = require("concord")
local systems = require("systems")

return function(world)
	world:addSystems(unpack(systems.default))
	world:addSystems(systems.message)
	world:getSystem(systems.shoot):setEnabled(false)
	world:setResource("message", "Welcome to a shitty Osmos clone")
	Concord.entity(world):give("timer", 3, function(entity)
		world:setResource("message", "Absorb small masses. Avoid large masses")
		entity:destroy()
	end)
	Concord.entity(world):give("timer", 6, function(entity)
		world:setResource("message", nil)
		world:addSystem(systems.goal)
		world:setResource("goal", {
			title = "Grow to 1 microgram",
			condition = function()
				local player = world:getResource("player")
				return player.mass.val >= 1000000
			end,
		})
		entity:destroy()
	end)
end
