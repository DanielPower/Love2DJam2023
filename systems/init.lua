local systems = {
	collision = require("systems.collision"),
	death = require("systems.death"),
	orbDraw = require("systems.orbDraw"),
	fpsCounter = require("systems.fpsCounter"),
	gravity = require("systems.gravity"),
	hud = require("systems.hud"),
	move = require("systems.move"),
	shoot = require("systems.shoot"),
	timer = require("systems.timer"),
	goal = require("systems.goal"),
	message = require("systems.message"),
	cursedSound = require("systems.cursedSound"),
	growth = require("systems.growth"),
}

systems.default = {
	systems.collision,
	systems.death,
	systems.orbDraw,
	systems.fpsCounter,
	systems.hud,
	systems.move,
	systems.shoot,
	systems.timer,
	systems.cursedSound,
	systems.growth,
}

return systems
