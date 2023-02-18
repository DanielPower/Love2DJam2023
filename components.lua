local Concord = require("concord")
local Vec = require("vec")

Concord.component("body", function(component, position, mass, options)
	if not options then
		options = {}
	end
	component.position = position
	component.mass = mass
	component.velocity = options.velocity or Vec.of(0)
	component.force = options.force or Vec.of(0)
end)

Concord.component("player")
Concord.component("dead")
