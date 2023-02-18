local Concord = require("concord")
local Vec = require("vec")

local ShootSystem = Concord.system({
	pool = { "player", "body" },
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
		local massLost = e.body.mass * shotSize
		e.body.mass = e.body.mass - massLost
		local relativeVelocity = Vec.new(worldX, worldY):sub(e.body.position):normalize():scale(SHOT_VELOCITY)
		Concord.entity(world)
			:give("body", e.body.position:clone(), massLost, { velocity = e.body.velocity:add(relativeVelocity) })
		e.body.force = e.body.force:sub(relativeVelocity:scale(massLost))
	end
end

return ShootSystem
