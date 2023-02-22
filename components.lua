local Concord = require("concord")
local Vec = require("vec")

Concord.component("position", function(component, position)
	component.val = position
end)

Concord.component("mass", function(component, mass)
	component.val = mass
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

Concord.component("player")
Concord.component("dead")
