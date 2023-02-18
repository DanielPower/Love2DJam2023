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

function love.mousepressed(x, y, button)
	world:emit("mousepressed", world, x, y, button)
end

function love.update(dt)
	world:emit("update", world, dt)
end

function love.draw()
	world:emit("draw", world)
end
