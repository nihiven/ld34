-- all game related values
-- anything an entity could need that is related to scoring or game control should go here?

game = { 
	paused = false,
	
	-- time
	timeLimit = 180,
	timeElapsed = 0,

	-- scoring
	score = 0,
	scoreBase = 100,
	scoreMultiplier = 1.5, -- multiplier * level
	scoreSpeedTime = 3, -- must answer in value seconds to get % of bonus
	scoreSpeedMultiplier = 2, -- value is 100% of the bonus
	correct = 0,
	incorrect = 0,

	-- levels
	level = 1,
	levelMax = 4,

	newgame = function(self) -- fix please
		self.paused = false
		
		-- time
		self.timeLimit = 180
		self.timeElapsed = 0

		-- scoring
		self.score = 0
		self.scoreBase = 100
		self.scoreMultiplier = 1.5 -- multiplier * level
		self.scoreSpeedTime = 3, -- must answer in value seconds to get % of bonus
		self.scoreSpeedMultiplier = 3
		self.correct = 0
		self.incorrect = 0

		-- levels
		self.level = 1
		self.levelMax = 4
	end
}
