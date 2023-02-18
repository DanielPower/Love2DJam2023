local Concord = require("concord")
local Vec = require("vec")

local ShootSystem = Concord.system({
	pool = { "player", "body" },
})

local SHOT_VELOCITY = 600

function ShootSystem:mousepressed(world, x, y)
	for _, e in ipairs(self.pool) do
		print(e.body.velocity)
		local massLost = e.body.mass * 0.05
		e.body.mass = e.body.mass - massLost
		local relativeVelocity = e.body.position:sub(Vec.new(x, y)):normalize():scale(SHOT_VELOCITY)
		print(e, relativeVelocity)
		Concord.entity(world)
			:give("body", e.body.position:clone(), massLost, { velocity = e.body.velocity:sub(relativeVelocity) })
		e.body.force = e.body.force:add(relativeVelocity)
	end
end

return ShootSystem
