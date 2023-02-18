local util = require("util")
local Concord = require("concord")

local PLAYER_COLOR = { 0.5, 0.5, 1 }
local SMALL_ORB_COLOR = { 0.5, 1, 0.5 }
local LARGE_ORB_COLOR = { 1, 0.5, 1 }

local DrawSystem = Concord.system({
	pool = { "body" },
	player = { "player" },
})

function DrawSystem:draw()
	local player = self.player[1]
	local world = self:getWorld()
	local camera = world:getResource("camera")
	camera:setPosition(player.body.position.x, player.body.position.y)
	camera:draw(function()
		for _, e in ipairs(self.pool) do
			if e.player then
				love.graphics.setColor(PLAYER_COLOR)
			elseif e.body.mass < player.body.mass then
				love.graphics.setColor(SMALL_ORB_COLOR)
			else
				love.graphics.setColor(LARGE_ORB_COLOR)
			end
			love.graphics.circle("fill", e.body.position.x, e.body.position.y, util.bodyRadius(e.body))
		end
	end)
end

return DrawSystem
