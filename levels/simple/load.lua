local Concord = require("concord")

return function(world)
	Concord.entity(world):give("timer", 1, function()
		world:setResource("message", "Welcome")
	end)
	Concord.entity(world):give("timer", 3, function()
		world:setResource("message", "Go fuck yourself")
	end)
	Concord.entity(world):give("timer", 5, function()
		world:setResource("message", nil)
	end)
end
