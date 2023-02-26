local Concord = require("concord")
local systems = require("systems")

return function(world)
	world:addSystem(systems.message)
	world:addSystem(systems.goal)
	world:getSystem(systems.move):setEnabled(false)
	world:getSystem(systems.shoot):setEnabled(false)
	world:setResource("message", "Welcome to a shitty Osmos clone")
	Concord.entity(world):give("timer", 3, function(entity)
		world:setResource("message", "The goal is to get big")
		entity:destroy()
	end)
	Concord.entity(world):give("timer", 6, function(entity)
		world:setResource("message", "Click to emit mass.\nAbsorb small masses. Avoid large masses")
		entity:destroy()
	end)
	Concord.entity(world):give("timer", 10, function(entity)
		world:setResource("message", nil)
		entity:destroy()
		world:getSystem(systems.move):setEnabled(true)
		world:getSystem(systems.shoot):setEnabled(true)
		world:setResource("goal", {
			title = "Grow to 1 nanogram",
			condition = function()
				local player = world:getResource("player")
				return player.mass.val >= 1000
			end,
		})
	end)
end
