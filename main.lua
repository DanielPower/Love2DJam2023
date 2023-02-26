require("components")
local worldManager = require("world")
worldManager.loadMap("simple")

local paused = false

function love.keypressed(key)
	if key == "p" then
		paused = not paused
	elseif key == "1" then
		worldManager.loadMap("simple")
	elseif key == "2" then
		worldManager.loadMap("playground")
	end
end

function love.mousepressed(x, y, button)
	worldManager.world:emit("mousepressed", x, y, button)
end

function love.update(dt)
	if not paused then
		worldManager.world:emit("update", dt)
	end
end

function love.draw()
	worldManager.world:emit("draw")
end
