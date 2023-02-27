local Concord = require("concord")

local GrowthSystem = Concord.system({
	pool = { "growth" },
})

function GrowthSystem:update()
	for _, e in ipairs(self.pool) do
		e.mass.val = e.mass.val + e.growth.val
		e.growth.val = 0
	end
end

return GrowthSystem
