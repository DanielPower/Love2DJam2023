local Concord = require("concord")

local DeathSystem = Concord.system({
	pool = { "dead" },
})

function DeathSystem:update()
	for _, e in ipairs(self.pool) do
		if not e.player then
			e:destroy()
		end
	end
end

return DeathSystem
