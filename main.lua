require("components")
local Concord = require("concord")
local MoveSystem = require("systems.move")
local GravitySystem = require("systems.gravity")
local DrawSystem = require("systems.draw")
local ShootSystem = require("systems.shoot")
local CollisionSystem = require("systems.collision")
local FpsCounterSystem = require("systems.fpsCounter")
local Vec = require("vec")

local world = Concord.world()

local paused = false

world:addSystems(MoveSystem, GravitySystem, DrawSystem, ShootSystem, CollisionSystem, FpsCounterSystem)

Concord.entity(world):give("body", Vec(400, 300), 20):give("player")
Concord.entity(world):give("body", Vec(150, 0), 40)
Concord.entity(world):give("body", Vec(300, 600), 80)
Concord.entity(world):give("body", Vec(400, 200), 30)
Concord.entity(world):give("body", Vec(200, 400), 15)

function love.keypressed(key)
	if key == "p" then
		paused = not paused
	end
end

function love.mousepressed(x, y, button)
	world:emit("mousepressed", x, y, button)
end

function love.update(dt)
	if not paused then
		world:emit("update", dt)
	end
end

function love.draw()
	world:emit("draw")
end
