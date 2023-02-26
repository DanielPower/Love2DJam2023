local Concord = require("concord")

local DeathSystem = Concord.system({
	pool = { "mass" },
})

function DeathSystem:update()
	for _, e in ipairs(self.pool) do
		if e.mass.val < 1 then
			e:destroy()
		end
	end
end

return DeathSystem
