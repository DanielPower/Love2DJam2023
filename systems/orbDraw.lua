local util = require("util")
local Concord = require("concord")
local tween = require("tween")

local PLAYER_COLOR = { 0.5, 0.5, 1 }
local SMALL_ORB_COLOR = { 0.5, 1, 0.5 }
local LARGE_ORB_COLOR = { 1, 0.5, 1 }
local CAMERA_SCALE = 60

local OrbDrawSystem = Concord.system({
	pool = { "mass", "position" },
	player = { "player" },
})

function OrbDrawSystem:update(dt)
	local world = self:getWorld()
	local player = world:getResource("player")
	local camera = world:getResource("camera")
	local currentScale = camera:getScale()
	local desiredScale = CAMERA_SCALE / util.massToRadius(player.mass.val)
	local tmp = { scale = currentScale }
	local cameraTween = tween.new(1, tmp, { scale = desiredScale }, "outCubic")
	cameraTween:update(dt)
	camera:setScale(math.min(tmp.scale, 1))
	camera:setPosition(player.position.val.x, player.position.val.y)
end

function OrbDrawSystem:draw()
	local world = self:getWorld()
	local player = world:getResource("player")
	local playerMass = player.mass.val
	local camera = world:getResource("camera")
	local x1, y1, w, h = camera:getVisible()
	local x2, y2 = x1 + w, y1 + h
	camera:draw(function()
		love.graphics.setBackgroundColor(world:getResource("backgroundColor"))
		for _, e in ipairs(self.pool) do
			local mass = e.mass.val
			local px = e.position.val.x
			local py = e.position.val.y
			local radius = util.massToRadius(mass)
			if px > x1 - radius and px < x2 + radius and py > y1 - radius and py < y2 + radius then
				if e.player then
					love.graphics.setColor(PLAYER_COLOR)
				elseif mass < playerMass then
					love.graphics.setColor(SMALL_ORB_COLOR)
				else
					love.graphics.setColor(LARGE_ORB_COLOR)
				end
				love.graphics.circle("fill", px, py, radius)
			end
		end
	end)
end

return OrbDrawSystem
