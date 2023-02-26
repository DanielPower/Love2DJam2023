local Concord = require("concord")
local gamera = require("gamera")
local util = require("util")

local camera = gamera.new(-math.huge, -math.huge, math.huge, math.huge)
local levels = { "tutorial", "simple", "playground" }
local levelIndex = 1

local worldManager = {}

function worldManager.loadMap(mapName)
	worldManager.world = Concord.world()
	worldManager.world:setResource("camera", camera)
	function worldManager.world:onEntityRemoved(e)
		if e:has("player") then
			worldManager.loadMap(mapName)
		end
	end
	util.loadTiledMap(worldManager.world, mapName)
end

function worldManager.nextMap()
	levelIndex = levelIndex + 1
	worldManager.loadMap(levels[levelIndex])
end

function worldManager.restartMap()
	worldManager.loadMap(levels[levelIndex])
end

return worldManager
