local Concord = require("concord")
local systems = require("systems")

return function(world)
	world:addSystems(unpack(systems.default))
	world:addSystem(systems.message)
	world:getSystem(systems.shoot):setEnabled(false)
	world:setResource("message", "Click anywhere to emit mass in that direction")
	Concord.entity(world):give("timer", 3, function(entity)
		world:setResource("message", "You will be propelled in the opposite direction")
		entity:destroy()
	end)
	Concord.entity(world):give("timer", 6, function(entity)
		world:setResource("message", nil)
		world:getSystem(systems.shoot):setEnabled(true)
		world:addSystem(systems.goal)
		world:setResource("goal", {
			title = "Grow to 10 micrograms",
			condition = function()
				local player = world:getResource("player")
				return player.mass.val >= 10000000
			end,
		})
		entity:destroy()
	end)
end
