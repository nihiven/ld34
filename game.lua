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
	scoreMultiplier = 1, -- multiplier * level
	correct = 0,
	incorrect = 0,

	-- levels
	level = 1,
	levelMax = 3,
	levelProblems = 20,

	newgame = function(self) -- fix please
		self.paused = false
		
		-- time
		self.timeLimit = 180
		self.timeElapsed = 0

		-- scoring
		self.score = 0
		self.scoreBase = 100
		self.scoreMultiplier = 1 -- multiplier * level
		self.correct = 0
		self.incorrect = 0

		-- levels
		self.level = 1
		self.levelMax = 3
		self.levelProblems = 20
	end
}
