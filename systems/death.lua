local Concord = require("concord")

local DeathSystem = Concord.system({
	pool = { "mass" },
})

function DeathSystem:update()
	for _, e in ipairs(self.pool) do
		if e.mass.val < 1 then
			if e:has("player") then
				e:give("dead")
			else
				e:destroy()
			end
		end
	end
end

return DeathSystem
