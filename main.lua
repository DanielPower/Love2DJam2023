require("components")
local worldManager = require("world")
worldManager.loadMap("tutorial")

local paused = false
music = love.audio.newSource("res/ambient.mp3", "stream") -- the "stream" tells LÖVE to stream the file from disk, good for longer music tracks
music:play()

function love.keypressed(key)
	if key == "p" then
		paused = not paused
	elseif key == "q" then
		love.event.quit()
	elseif key == "r" then
		worldManager.restartMap()
	elseif key == "1" then
		worldManager.loadMap("tutorial")
	elseif key == "2" then
		worldManager.loadMap("simple")
	elseif key == "3" then
		worldManager.loadMap("playground")
	else
		worldManager.world:emit("keypressed", key)
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
