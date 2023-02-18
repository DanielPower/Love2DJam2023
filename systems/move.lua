local Concord = require("concord")
local Vec2 = require("cpml.vec2")

local MoveSystem = Concord.system({
	pool = { "body" },
})

function MoveSystem:update(dt)
	for _, e in ipairs(self.pool) do
		e.body.position:add(e.body.position, e.body.velocity.scale(Vec2.new(), e.body.velocity, dt))
	end
end

return MoveSystem
