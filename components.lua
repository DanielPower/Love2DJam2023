local Concord = require("concord")
local Vec2 = require("cpml.vec2")

Concord.component("body", function(component, x, y, vx, vy, mass)
	print(x, y, vx, vy, mass)
	component.position = Vec2.new(x, y)
	component.velocity = Vec2.new(vx, vy)
	component.mass = mass
end)

Concord.component("player")
