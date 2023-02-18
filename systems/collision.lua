local Concord = require("concord")
local util = require("util")

local CollisionSystem = Concord.system({
	pool = { "body" },
})

function CollisionSystem:update()
	for i = 1, #self.pool do
		for j = i + 1, #self.pool do
			local e1 = self.pool[i]
			local e2 = self.pool[j]
			local smaller, larger
			if e1.body.mass < e2.body.mass then
				smaller, larger = e1, e2
			else
				smaller, larger = e2, e1
			end
			local smallRadius = util.bodyRadius(smaller.body)
			local largeRadius = util.bodyRadius(larger.body)
			local dist = e1.body.position:dist(e2.body.position)
			local overlap = smallRadius + largeRadius - dist
			local e1Immune = e1:has("immunity") and e1.immunity.entity == e2
			local e2Immune = e2:has("immunity") and e2.immunity.entity == e1
			if overlap > 0 then
				if not e1Immune and not e2Immune then
					local massTransferred = util.radiusToMass(smallRadius)
						- util.radiusToMass(smallRadius - overlap / 2)
					smaller.body.mass = smaller.body.mass - massTransferred
					larger.body.mass = larger.body.mass + massTransferred
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
