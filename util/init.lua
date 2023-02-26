local Concord = require("concord")
local Vec = require("vec")

local util = {}

function util.massToRadius(mass)
	return math.sqrt(mass / math.pi)
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
	velocity = function(e, o)
		e:give("velocity", Vec(o.value.x, o.value.y))
	end,
	force = function(e, o)
		e:give("force", Vec(o.value.x, o.value.y))
	end,
	autoMass = function(e, o)
		e:give("mass", util.radiusToMass(o.properties.width / 2))
	end,
	mass = function(e, o)
		e:give("mass", o.value)
	end,
	timer = function(e, o)
		e:ensure("timer", {})
		e.timer.timers[o.index] = {
			time = o.value.time,
			-- HACK This is cursed and shouldn't work, because map paths are relative
			callback = require("levels/" .. util.split(o.value.callback, ".lua")[1]),
		}
	end,
}

function util.loadTiledObject(world, object)
	local entity = Concord.entity(world)
	entity:give("position", Vec(object.x, object.y))
	for property, value in pairs(object.properties) do
		print(property)
		local propertyName, index = unpack(util.split(property, "."))
		print(propertyName, index)
		if componentResolvers[propertyName] then
			componentResolvers[propertyName](entity, {
				value = value,
				index = index,
				properties = object,
			})
		end
	end
end

function util.getMapFile(mapName, file)
	return "levels." .. mapName .. "." .. file
end

function util.loadTiledMap(world, mapName)
	local map = require(util.getMapFile(mapName, "map"))
	local objects
	world:setResource(
		"backgroundColor",
		{ map.backgroundcolor[1] / 255, map.backgroundcolor[2] / 255, map.backgroundcolor[3] / 255 }
	)
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
	require(util.getMapFile(mapName, "load"))(world)
end

local function gsplit(text, pattern, plain)
	if plain == nil then
		plain = true
	end
	local splitStart, length = 1, #text
	return function()
		if splitStart then
			local sepStart, sepEnd = string.find(text, pattern, splitStart, plain)
			local ret
			if not sepStart then
				ret = string.sub(text, splitStart)
				splitStart = nil
			elseif sepEnd < sepStart then
				-- Empty separator!
				ret = string.sub(text, splitStart, sepStart)
				if sepStart < length then
					splitStart = sepStart + 1
				else
					splitStart = nil
				end
			else
				ret = sepStart > splitStart and string.sub(text, splitStart, sepStart - 1) or ""
				splitStart = sepEnd + 1
			end
			return ret
		end
	end
end

function util.split(text, pattern, plain)
	local ret = {}
	for match in gsplit(text, pattern, plain) do
		table.insert(ret, match)
	end
	return ret
end

return util
