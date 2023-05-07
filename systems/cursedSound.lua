local Concord = require("concord")

local CursedSoundSystem = Concord.system()

local lastDt
local source

function CursedSoundSystem:update(dt)
	lastDt = dt
end

function CursedSoundSystem:playerCollision(player, other)
	local sizeRatio = player.mass.val / other.mass.val
	local rate = 44100 -- samples per second
	local length = lastDt * 2
	local tone = 200 * (sizeRatio + 0.3) -- Hz
	local p = math.floor(rate / tone) -- 100 (wave length in samples)
	local soundData = love.sound.newSoundData(math.floor(length * rate), rate, 16, 1)
	for i = 0, soundData:getSampleCount() - 1 do
		soundData:setSample(i, math.sin(2 * math.pi * i / p)) -- sine wave.
		-- soundData:setSample(i, i%p<p/2 and 1 or -1)     -- square wave; the first half of the wave is 1, the second half is -1.
	end
	if source then
		source:stop()
	end
	source = love.audio.newSource(soundData)
	source:setVolume(0.5)
	source:play()
end

return CursedSoundSystem
