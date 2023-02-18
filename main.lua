require("components")
local Concord = require("concord")
local MoveSystem = require("systems.move")
local GravitySystem = require("systems.gravity")
local DrawSystem = require("systems.draw")

local world = Concord.world()

world:addSystems(MoveSystem, GravitySystem, DrawSystem)

Concord.entity(world):give("body", 300, 600, 0, 0, 20)
Concord.entity(world):give("body", 300, 300, 0, 0, 5)
Concord.entity(world):give("body", 500, 100, 0, 0, 30)

function love.update(dt)
	world:emit("update", dt)
end

function love.draw()
	world:emit("draw")
end
