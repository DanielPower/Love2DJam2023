local Concord = require("concord")

local TimerSystem = Concord.system({
	pool = { "timer" },
})

function TimerSystem:update(dt)
	for _, e in ipairs(self.pool) do
		for _, t in pairs(e.timer.timers) do
			t.time = t.time - dt
			if t.time <= 0 then
				t.callback(e)
			end
		end
	end
end

return TimerSystem
