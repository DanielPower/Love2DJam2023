local Concord = require("concord")
local Vec = require("vec")

local ShootSystem = Concord.system({
	pool = { "player", "mass", "position" },
})

local SHOT_VELOCITY = 600
local SMALL_SHOT_MASS = 0.05
local LARGE_SHOT_MASS = 0.15

function ShootSystem:mousepressed(x, y, button)
	local world = self:getWorld()
	local camera = world:getResource("camera")
	local worldX, worldY = camera:toWorld(x, y)
	local shotSize
	if button == 1 then
		shotSize = SMALL_SHOT_MASS
	elseif button == 2 then
		shotSize = LARGE_SHOT_MASS
	else
		return
	end
	for _, e in ipairs(self.pool) do
		local massLost = e.mass.val * shotSize
		e.mass.val = e.mass.val - massLost
		local relativeVelocity = Vec.new(worldX, worldY):sub(e.position.val):normalize():scale(SHOT_VELOCITY)
		Concord.entity(world)
			:give("position", e.position.val:clone())
			:give("mass", massLost)
			:give("velocity", e.velocity.val:add(relativeVelocity))
			:give("immunity", e)
		e.force.val = e.force.val:sub(relativeVelocity:scale(massLost))
	end
end

return ShootSystem
