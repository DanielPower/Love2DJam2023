require("components")
local Concord = require("concord")
local MoveSystem = require("systems.move")
local GravitySystem = require("systems.gravity")
local DrawSystem = require("systems.draw")
local ShootSystem = require("systems.shoot")
local CollisionSystem = require("systems.collision")
local FpsCounterSystem = require("systems.fpsCounter")
local DeathSystem = require("systems.death")
local gamera = require("gamera")
local playgroundMap = require("levels.playground")
local util = require("util")

local gameWorld = Concord.world()
gameWorld:addSystems(FpsCounterSystem)

local paused = false
local camera = gamera.new(-math.huge, -math.huge, math.huge, math.huge)

local levelWorld = Concord.world()
levelWorld:addSystems(MoveSystem, GravitySystem, DrawSystem, ShootSystem, CollisionSystem, DeathSystem)
levelWorld:setResource("camera", camera)

util.loadTiledMap(levelWorld, playgroundMap)

function love.keypressed(key)
	if key == "p" then
		paused = not paused
	end
end

function love.mousepressed(x, y, button)
	levelWorld:emit("mousepressed", x, y, button)
end

function love.update(dt)
	gameWorld:emit("update", dt)
	if not paused then
		levelWorld:emit("update", dt)
	end
end

function love.draw()
	levelWorld:emit("draw")
	gameWorld:emit("draw")
end
