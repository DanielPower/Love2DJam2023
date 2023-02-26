local Concord = require("concord")
local fonts = require("fonts")

local HudSystem = Concord.system()

local fps

local massUnits = {
	"pico",
	"nano",
	"micro",
	"milli",
	"",
	"kilo",
	"mega",
	"giga",
	"tera",
	"peta",
	"exa",
	"zetta",
	"yotta",
}

function HudSystem:update(dt)
	fps = 1 / dt
end

function HudSystem:draw()
	local world = self:getWorld()
	local player = world:getResource("player")
	local massUnitIndex = math.floor(math.log(player.mass.val, 1000))
	local massUnit = massUnits[massUnitIndex + 1]
	local mass = player.mass.val / 1000 ^ massUnitIndex
	local decimalPlaces = math.ceil(math.log(mass, 10))
	love.graphics.setFont(fonts.hud)
	love.graphics.setColor(1, 1, 1)
	love.graphics.print(
		"Mass: " .. string.format("%." .. 4 - decimalPlaces .. "f", mass) .. " " .. massUnit .. "grams",
		10,
		love.graphics.getHeight() - fonts.hud:getHeight() - 10
	)
end

return HudSystem
