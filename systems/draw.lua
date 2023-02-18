local util = require("util")
local Concord = require("concord")

local PLAYER_COLOR = { 0.5, 0.5, 1 }
local SMALL_ORB_COLOR = { 0.5, 1, 0.5 }
local LARGE_ORB_COLOR = { 1, 0.5, 1 }
local GRAVITY_COLOR = { 0.5, 1, 0.5 }

local DrawSystem = Concord.system({
	pool = { "body" },
})

function DrawSystem:draw()
	for _, e in ipairs(self.pool) do
		if e.player then
			love.graphics.setColor(PLAYER_COLOR)
		elseif e.gravity then
			love.graphics.setColor(GRAVITY_COLOR)
		else
			love.graphics.setColor(LARGE_ORB_COLOR)
		end
		love.graphics.circle("fill", e.body.position.x, e.body.position.y, util.bodyRadius(e.body))
	end
end

return DrawSystem
