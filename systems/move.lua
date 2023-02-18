local Concord = require("concord")
local Vec = require("vec")

local MoveSystem = Concord.system({
	pool = { "body" },
})

function MoveSystem:update(dt)
	for _, e in ipairs(self.pool) do
		if e.player then
			print(e.body.velocity, e.body.position, e.body.mass)
		end
		if not e.dead then
			e.body.velocity = e.body.velocity:add(e.body.force:scale(1 / e.body.mass))
		end
		e.body.force = Vec.of(0)
		e.body.position = e.body.position:add(e.body.velocity:scale(dt))
	end
end

return MoveSystem
