local Concord = require("concord")
local Vec = require("vec")
local ORB_SCALE = 10

local util = {}

function util.bodyRadius(body)
	return math.sqrt(body.mass / math.pi) * ORB_SCALE
end

function util.radiusToMass(radius)
	if radius <= 0 then
		return 0
	end
	return (math.pi * radius ^ 2) / ORB_SCALE ^ 2
end

function util.loadTiledObject(world, object)
	local entity = Concord.entity(world)
	entity:give("body", Vec(object.x, object.y), util.radiusToMass(object.width / 2))
	if object.properties.player then
		entity:give("player")
	end
end

function util.loadTiledMap(world, map)
	local objects
	for _, layer in ipairs(map.layers) do
		if layer.name == "Objects" then
			objects = layer.objects
		end
	end
	if not objects then
		print("No objects found")
		return
	end
	for _, object in ipairs(objects) do
		util.loadTiledObject(world, object)
	end
end

return util
