require("components")
local worldManager = require("world")
worldManager.loadMap("tutorial")

local paused = false
local minDt = 1 / 60
local lastTime = love.timer.getTime()
local nextTime = 0

function love.keypressed(key)
	if key == "p" then
		paused = not paused
	elseif key == "1" then
		worldManager.loadMap("tutorial")
	elseif key == "2" then
		worldManager.loadMap("playground")
	end
end

function love.mousepressed(x, y, button)
	worldManager.world:emit("mousepressed", x, y, button)
end

function love.update()
	local currentTime = love.timer.getTime()
	if currentTime >= nextTime then
		local dt = currentTime - lastTime
		lastTime = currentTime
		nextTime = currentTime + minDt
		if not paused then
			print(worldManager.world:getResource("player").position.val)
			worldManager.world:emit("update", dt)
		end
	end
end

function love.draw()
	worldManager.world:emit("draw")
end
