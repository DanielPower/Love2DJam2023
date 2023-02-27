local Concord = require("concord")
local Vec = require("vec")

Concord.component("position", function(component, position)
	component.val = position
end)

Concord.component("mass", function(component, mass)
	component.val = mass
end)

Concord.component("growth", function(component, growth)
	component.val = growth
end)

Concord.component("velocity", function(component, velocity)
	component.val = velocity or Vec.of(0)
end)

Concord.component("force", function(component, force)
	component.val = force or Vec.of(0)
end)

Concord.component("immunity", function(component, entity)
	component.entity = entity
end)

Concord.component("timer", function(component, ...)
	local args = { ... }
	if type(args[1]) == "number" then
		component.timers = { {
			time = args[1],
			callback = args[2],
		} }
	else
		component.timers = args[1]
	end
end)

Concord.component("player")
