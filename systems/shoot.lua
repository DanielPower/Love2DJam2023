local Concord = require("concord")
local Vec = require("vec")

local ShootSystem = Concord.system({
	pool = { "player", "body" },
})

local SHOT_VELOCITY = 600

function ShootSystem:mousepressed(x, y)
	for _, e in ipairs(self.pool) do
		local massLost = e.body.mass * 0.05
		e.body.mass = e.body.mass - massLost
		local relativeVelocity = Vec.new(x, y):sub(e.body.position):normalize():scale(SHOT_VELOCITY)
		Concord.entity(self:getWorld())
			:give("body", e.body.position:clone(), massLost, { velocity = e.body.velocity:add(relativeVelocity) })
		e.body.force = e.body.force:sub(relativeVelocity)
	end
end

return ShootSystem
