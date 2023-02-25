local Concord = require("concord")
local Vec = require("vec")

local util = {}

function util.massToRadius(mass)
	return math.sqrt(mass) / math.pi
end

function util.radiusToMass(radius)
	if radius <= 0 then
		return 0
	end
	return math.pi * radius ^ 2
end

local componentResolvers = {
	player = function(e)
		e:give("player")
	end,
	velocity = function(e, v)
		e:give("velocity", Vec(v.x, v.y))
	end,
	force = function(e, v)
		e:give("force", Vec(v.x, v.y))
	end,
	autoMass = function(e, _, p)
		e:give("mass", util.radiusToMass(p.width / 2))
	end,
	mass = function(e, v)
		e:give("mass", v)
	end,
}

function util.loadTiledObject(world, object)
	local entity = Concord.entity(world)
	entity:give("position", Vec(object.x, object.y))
	for property, value in pairs(object.properties) do
		if componentResolvers[property] then
			componentResolvers[property](entity, value, object)
		end
	end
end

function util.loadTiledMap(world, map)
	local objects
	for _, layer in ipairs(map.layers) do
		if layer.name == "Objects" then
			objects = layer.objects
		end
		world:setResource(
			"backgroundColor",
			{ map.backgroundcolor[1] / 255, map.backgroundcolor[2] / 255, map.backgroundcolor[3] / 255 }
		)
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
