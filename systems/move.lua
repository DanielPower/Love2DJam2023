local Concord = require("concord")
local Vec = require("vec")

local MoveSystem = Concord.system({
	move = { "velocity", "position" },
	force = { "force", "velocity" },
})

function MoveSystem:update(dt)
	for _, e in ipairs(self.move) do
		e.position.val = e.position.val:add(e.velocity.val:scale(dt))
	end
	for _, e in ipairs(self.force) do
		if not e.dead then
			e.velocity.val = e.velocity.val:add(e.force.val:scale(1 / e.mass.val))
		end
		e.force.val = Vec.of(0)
	end
end

return MoveSystem
