local util = require("util")
local Concord = require("concord")

local PLAYER_COLOR = { 0.5, 0.5, 1 }
local SMALL_ORB_COLOR = { 0.5, 1, 0.5 }
local LARGE_ORB_COLOR = { 1, 0.5, 1 }

local DrawSystem = Concord.system({
	pool = { "mass", "position" },
	player = { "player" },
})

function DrawSystem:draw()
	local player = self.player[1]
	local world = self:getWorld()
	local camera = world:getResource("camera")
	camera:setPosition(player.position.val.x, player.position.val.y)
	camera:setScale(30 / util.massToRadius(player.mass.val))
	camera:draw(function()
		love.graphics.setBackgroundColor(world:getResource("backgroundColor"))
		for _, e in ipairs(self.pool) do
			if e.player then
				love.graphics.setColor(PLAYER_COLOR)
			elseif e.mass.val < player.mass.val then
				love.graphics.setColor(SMALL_ORB_COLOR)
			else
				love.graphics.setColor(LARGE_ORB_COLOR)
			end
			love.graphics.circle("fill", e.position.val.x, e.position.val.y, util.massToRadius(e.mass.val))
		end
	end)
end

return DrawSystem
