local Concord = require("concord")
local level = {}

level.init = function()
	local world = Concord.world()
	world:addSystems(MoveSystem, GravitySystem, DrawSystem, ShootSystem, CollisionSystem, FpsCounterSystem)
	Concord.entity(world):give("body", Vec(400, 300), 20):give("player")
	Concord.entity(world):give("body", Vec(150, 0), 40)
	Concord.entity(world):give("body", Vec(300, 600), 80)
	Concord.entity(world):give("body", Vec(400, 200), 30)
	Concord.entity(world):give("body", Vec(200, 400), 15)
	return world
end
