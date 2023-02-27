local Concord = require("concord")
local util = require("util")

local CollisionSystem = Concord.system({
	pool = { "mass", "position" },
})

function CollisionSystem:update()
	local world = self:getWorld()
	local camera = world:getResource("camera")
	local player = world:getResource("player")
	local pMass = player.mass.val
	local cx1, cy1, w, h = camera:getVisible()
	local cx2, cy2 = cx1 + w, cy1 + h
	for i = 1, #self.pool do
		local e1 = self.pool[i]
		local e1x = e1.position.val.x
		local e1y = e1.position.val.y
		local e1Mass = e1.mass.val
		local e1Radius = util.massToRadius(e1Mass)
		if e1x > cx1 - e1Radius and e1x < cx2 + e1Radius and e1y > cy1 - e1Radius and e1y < cy2 + e1Radius then
			for j = i + 1, #self.pool do
				local e2 = self.pool[j]
				local e2x = e2.position.val.x
				local e2y = e2.position.val.y
				local e2Mass = e2.mass.val
				local e2Radius = util.massToRadius(e2Mass)
				if e2x > cx1 - e2Radius and e2x < cx2 + e2Radius and e2y > cy1 - e2Radius and e2y < cy2 + e2Radius then
					local smaller, smallerMass, smallerRadius
					local larger, largerRadius
					if e1Mass < e2Mass then
						smaller = e1
						smallerMass = e1Mass
						smallerRadius = e1Radius
						larger = e2
						largerRadius = e2Radius
					else
						smaller = e2
						smallerMass = e2Mass
						smallerRadius = e2Radius
						larger = e1
						largerRadius = e1Radius
					end
					if smallerMass > pMass / 100 or larger:has("player") then
						local dist = e1.position.val:dist(e2.position.val)
						local overlap = smallerRadius + largerRadius - dist
						local e1Immune = e1:has("immunity") and e1.immunity.entity == e2
						local e2Immune = e2:has("immunity") and e2.immunity.entity == e1
						if overlap > 0 then
							if not e1Immune and not e2Immune then
								local massTransferred = smallerMass - util.radiusToMass(smallerRadius - overlap / 2)
								smaller.growth.val = smaller.growth.val - massTransferred
								larger.growth.val = larger.growth.val + massTransferred
								if e1:has("player") then
									self:getWorld():emit("playerCollision", e1, e2)
								elseif e2:has("player") then
									self:getWorld():emit("playerCollision", e2, e1)
								end
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
		end
	end
end

return CollisionSystem
