local Concord = require("concord")
local Vec2 = require("cpml.vec2")
local util = require("util")

local GravitySystem = Concord.system({
	pool = { "body" },
})

function GravitySystem:update(dt)
	for i = 1, #self.pool do
		for j = i + 1, #self.pool do
			local e1 = self.pool[i]
			local e2 = self.pool[j]
			local distance =
				math.max(util.bodyRadius(e1.body) + util.bodyRadius(e2.body), e1.body.position:dist(e2.body.position))
			local magnitude = 60000 * math.sqrt(e1.body.mass * e2.body.mass) / distance ^ 2 * dt
			local angle = e2.body.position:angle_to(e1.body.position)
			local delta = Vec2.new(math.cos(angle) * magnitude, math.sin(angle) * magnitude)
			e1.body.velocity:add(e1.body.velocity, delta)
			e2.body.velocity:sub(e2.body.velocity, delta)
		end
	end
end

return GravitySystem
