local Concord = require("concord")
local gamera = require("gamera")
local util = require("util")
local systems = require("systems")

local camera = gamera.new(-math.huge, -math.huge, math.huge, math.huge)

local worldManager = {}

function worldManager.loadMap(mapName)
	worldManager.world = Concord.world()
	worldManager.world:addSystems(unpack(systems.default))
	worldManager.world:setResource("camera", camera)
	function worldManager.world:onEntityRemoved(e)
		if e:has("player") then
			worldManager.loadMap(mapName)
		end
	end
	util.loadTiledMap(worldManager.world, mapName)
end

return worldManager
