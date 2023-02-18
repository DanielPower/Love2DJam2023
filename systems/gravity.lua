local Concord = require("concord")
local Vec = require("vec")
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
			local magnitude = 6000 * math.sqrt(e1.body.mass * e2.body.mass) / distance ^ 2 * dt
			local angle = e2.body.position:angle_to(e1.body.position)
			local delta = Vec.new(math.cos(angle) * magnitude, math.sin(angle) * magnitude)
			e1.body.force = e1.body.force:add(delta)
			e2.body.force = e2.body.force:sub(delta)
		end
	end
end

return GravitySystem
