require("components")
local Concord = require("concord")
local MoveSystem = require("systems.move")
local GravitySystem = require("systems.gravity")
local DrawSystem = require("systems.draw")
local ShootSystem = require("systems.shoot")
local Vec = require("vec")

local world = Concord.world()

world:addSystems(MoveSystem, GravitySystem, DrawSystem, ShootSystem)

Concord.entity(world):give("body", Vec(400, 300), 20):give("player")
Concord.entity(world):give("body", Vec(0, 0), 40)
Concord.entity(world):give("body", Vec(800, 600), 80)
Concord.entity(world):give("body", Vec(400, 200), 50)
Concord.entity(world):give("body", Vec(200, 400), 15)

function love.mousepressed(x, y, button)
	world:emit("mousepressed", world, x, y, button)
end

function love.update(dt)
	world:emit("update", world, dt)
end

function love.draw()
	world:emit("draw", world)
end
