require("components")
local Concord = require("concord")
local MoveSystem = require("systems.move")
local GravitySystem = require("systems.gravity")
local DrawSystem = require("systems.draw")
local ShootSystem = require("systems.shoot")
local CollisionSystem = require("systems.collision")
local FpsCounterSystem = require("systems.fpsCounter")
local Vec = require("vec")
local gamera = require("gamera")

local world = Concord.world()

local paused = false

world:addSystems(MoveSystem, GravitySystem, DrawSystem, ShootSystem, CollisionSystem, FpsCounterSystem)

local player = Concord.entity(world):give("body", Vec(400, 300), 20):give("player")
Concord.entity(world):give("body", Vec(150, 0), 40)
Concord.entity(world):give("body", Vec(300, 600), 80)
Concord.entity(world):give("body", Vec(400, 200), 30)
Concord.entity(world):give("body", Vec(200, 400), 15)

local camera = gamera.new(-math.huge, -math.huge, math.huge, math.huge)

function love.keypressed(key)
	if key == "p" then
		paused = not paused
	end
end

function love.mousepressed(x, y, button)
	local worldX, worldY = camera:toWorld(x, y)
	world:emit("mousepressed", worldX, worldY, button)
end

function love.update(dt)
	camera:setPosition(player.body.position.x, player.body.position.y)
	if not paused then
		world:emit("update", dt)
	end
end

function love.draw()
	camera:draw(function(l, t, w, h)
		world:emit("draw", l, t, w, h)
	end)
end
