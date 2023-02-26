local Concord = require("concord")
local Vec = require("vec")
local util = require("util")

local GravitySystem = Concord.system({
	pool = { "position", "force", "mass" },
})

function GravitySystem:update(dt)
	for i = 1, #self.pool do
		for j = i + 1, #self.pool do
			local e1 = self.pool[i]
			local e2 = self.pool[j]
			local distance = math.max(
				util.massToRadius(e1.mass.val) + util.massToRadius(e2.mass.val),
				e1.position.val:dist(e2.position.val)
			)
			local magnitude = 6000000 * math.sqrt(e1.mass.val * e2.mass.val) / distance ^ 2 * dt
			local angle = e2.position.val:angle_to(e1.position.val)
			local delta = Vec.new(math.cos(angle) * magnitude, math.sin(angle) * magnitude)
			e1.force.val = e1.force.val:add(delta)
			e2.force.val = e2.force.val:sub(delta)
		end
	end
end

return GravitySystem
