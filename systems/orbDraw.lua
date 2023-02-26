local util = require("util")
local Concord = require("concord")
local tween = require("tween")

local PLAYER_COLOR = { 0.5, 0.5, 1 }
local SMALL_ORB_COLOR = { 0.5, 1, 0.5 }
local LARGE_ORB_COLOR = { 1, 0.5, 1 }

local OrbDrawSystem = Concord.system({
	pool = { "mass", "position" },
	player = { "player" },
})

function OrbDrawSystem:update(dt)
	local world = self:getWorld()
	local player = world:getResource("player")
	local camera = world:getResource("camera")
	local currentScale = camera:getScale()
	local desiredScale = 30 / util.massToRadius(player.mass.val)
	local tmp = { scale = currentScale }
	local cameraTween = tween.new(1, tmp, { scale = desiredScale }, "outCubic")
	cameraTween:update(dt)
	camera:setScale(math.min(tmp.scale, 1))
	camera:setPosition(player.position.val.x, player.position.val.y)
end

function OrbDrawSystem:draw()
	local world = self:getWorld()
	local player = world:getResource("player")
	local camera = world:getResource("camera")
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

return OrbDrawSystem
