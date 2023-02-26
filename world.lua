local Concord = require("concord")
local gamera = require("gamera")
local util = require("util")
local TimerSystem = require("systems.timer")
local MoveSystem = require("systems.move")
local GravitySystem = require("systems.gravity")
local DrawSystem = require("systems.draw")
local ShootSystem = require("systems.shoot")
local CollisionSystem = require("systems.collision")
local FpsCounterSystem = require("systems.fpsCounter")
local DeathSystem = require("systems.death")
local HudSystem = require("systems.hud")

local camera = gamera.new(-math.huge, -math.huge, math.huge, math.huge)

local worldManager = {}

function worldManager.loadMap(mapName)
	worldManager.world = Concord.world()
	worldManager.world:addSystems(
		TimerSystem,
		MoveSystem,
		GravitySystem,
		DrawSystem,
		ShootSystem,
		CollisionSystem,
		DeathSystem,
		FpsCounterSystem,
		HudSystem
	)
	worldManager.world:setResource("camera", camera)
	function worldManager.world:onEntityRemoved(e)
		if e:has("player") then
			worldManager.loadMap(mapName)
		end
	end
	util.loadTiledMap(worldManager.world, mapName)
end

return worldManager
