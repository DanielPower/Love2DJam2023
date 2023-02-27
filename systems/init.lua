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
}

systems.default = {
	systems.collision,
	systems.death,
	systems.orbDraw,
	-- systems.fpsCounter,
	-- systems.gravity,
	systems.hud,
	systems.move,
	systems.shoot,
	systems.timer,
	systems.cursedSound,
}

return systems
