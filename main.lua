require("components")
local Concord = require("concord")
local TimerSystem = require("systems.timer")
local MoveSystem = require("systems.move")
local GravitySystem = require("systems.gravity")
local DrawSystem = require("systems.draw")
local ShootSystem = require("systems.shoot")
local CollisionSystem = require("systems.collision")
local FpsCounterSystem = require("systems.fpsCounter")
local DeathSystem = require("systems.death")
local gamera = require("gamera")
local util = require("util")

local paused = false
local camera = gamera.new(-math.huge, -math.huge, math.huge, math.huge)

local world = Concord.world()
world:addSystems(
	TimerSystem,
	MoveSystem,
	GravitySystem,
	DrawSystem,
	ShootSystem,
	CollisionSystem,
	DeathSystem,
	FpsCounterSystem
)
world:setResource("camera", camera)

util.loadTiledMap(world, "simple")

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
