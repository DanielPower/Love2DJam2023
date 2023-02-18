require("components")
local Concord = require("concord")
local MoveSystem = require("systems.move")
local GravitySystem = require("systems.gravity")
local DrawSystem = require("systems.draw")
local ShootSystem = require("systems.shoot")
local CollisionSystem = require("systems.collision")
local FpsCounterSystem = require("systems.fpsCounter")
local DeathSystem = require("systems.death")
local Vec = require("vec")
local gamera = require("gamera")
local playgroundMap = require("levels.playground")
local util = require("util")

local world = Concord.world()

local paused = false
local camera = gamera.new(-math.huge, -math.huge, math.huge, math.huge)

world:addSystems(MoveSystem, GravitySystem, DrawSystem, ShootSystem, CollisionSystem, DeathSystem, FpsCounterSystem)
world:setResource("camera", camera)

util.loadTiledMap(world, playgroundMap)

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
