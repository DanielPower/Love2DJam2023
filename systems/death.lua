local Concord = require("concord")

local DeathSystem = Concord.system({
	pool = { "body" },
})

function DeathSystem:update()
	for _, e in ipairs(self.pool) do
		if e.body.mass < 1 then
			if e.player then
				e:give("dead")
			else
				e:destroy()
			end
		end
	end
end

return DeathSystem
