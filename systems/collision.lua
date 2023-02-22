local Concord = require("concord")
local util = require("util")

local CollisionSystem = Concord.system({
	pool = { "mass", "position" },
})

function CollisionSystem:update()
	for i = 1, #self.pool do
		for j = i + 1, #self.pool do
			local e1 = self.pool[i]
			local e2 = self.pool[j]
			local smaller, larger
			if e1.mass.val < e2.mass.val then
				smaller, larger = e1, e2
			else
				smaller, larger = e2, e1
			end
			local smallRadius = util.massToRadius(smaller.mass.val)
			local largeRadius = util.massToRadius(larger.mass.val)
			local dist = e1.position.val:dist(e2.position.val)
			local overlap = smallRadius + largeRadius - dist
			local e1Immune = e1:has("immunity") and e1.immunity.entity == e2
			local e2Immune = e2:has("immunity") and e2.immunity.entity == e1
			if overlap > 0 then
				if not e1Immune and not e2Immune then
					local massTransferred = util.radiusToMass(smallRadius)
						- util.radiusToMass(smallRadius - overlap / 2)
					smaller.mass.val = smaller.mass.val - massTransferred
					larger.mass.val = larger.mass.val + massTransferred
				end
			else
				if e1Immune then
					e1:remove("immunity")
				end
				if e2Immune then
					e2:remove("immunity")
				end
			end
		end
	end
end

return CollisionSystem
