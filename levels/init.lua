local LevelManager = {}
local levelIndex = 1

LevelManager.levels = {
	require("levels.movement"),
}

function LevelManager:startLevel(level)
	self.world = self.levels[level].init()
end

function LevelManager:getLevel()
	return self.levels[levelIndex]
end

function LevelManager:nextLevel()
	levelIndex = levelIndex + 1
	self:startLevel(levelIndex)
end

function LevelManager:getLevelIndex()
	return levelIndex
end

return LevelManager
