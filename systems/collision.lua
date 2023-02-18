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
			if overlap > 0 then
				local massTransferred = util.radiusToMass(smallRadius) - util.radiusToMass(smallRadius - overlap / 2)
				smaller.body.mass = smaller.body.mass - massTransferred
				larger.body.mass = larger.body.mass + massTransferred
				if smaller.body.mass < 1 then
					larger.body.mass = larger.body.mass + smaller.body.mass
					smaller:give("dead")
				end
			end
		end
	end
end

return CollisionSystem
