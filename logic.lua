-- it's game time
problems = {
	generate = function(_level)
		_level = _level or 1

		local operators = {'+','-','*','/'}
		local queue = {}

		math.randomseed(os.time())

		if (_level == 1) then
			-- single digit addition and subtraction
			local count = 10

			for i = count, 1, -1 do
				oper = operators[math.random(1,2)]
				op1, op2 = math.random(1,9), math.random(1,9)

				if (op1 < op2 and oper == '-') then -- no negative answers
					op1, op2 = op2, op1
				end
				
				a = loadstring('ans = ' .. op1 .. '' .. oper .. '' .. op2)
				a()
				table.insert(queue, { operator1 = op1, operator2 = op2, operator = oper, answer = ans, level = _level, incorrect = 0})
			end
		elseif (_level == 2) then
			-- single digit multiplication and division
			local count = 10

			for i = count, 1, -1 do
				oper = operators[math.random(3,4)]

				if (oper == '/') then -- no fractions
					op2, ans = math.random(1,9), math.random(1,9)
					op1 = op2 * ans
				else
					op1, op2 = math.random(1,9), math.random(1,9)
				end
				
				a = loadstring('ans = ' .. op1 .. '' .. oper .. '' .. op2)
				a()
				table.insert(queue, { operator1 = op1, operator2 = op2, operator = oper, answer = ans, level = _level, incorrect = 0})
			end
		elseif (_level == 3) then
			-- double digit addition and subtraction
			local count = 5

			for i = count, 1, -1 do
				oper = operators[math.random(1,2)]
				op1, op2 = math.random(10,99), math.random(10,99)

				if (op1 < op2 and oper == '-') then -- no negative answers
					op1, op2 = op2, op1
				end

				a = loadstring('ans = ' .. op1 .. '' .. oper .. '' .. op2)
				a()
				table.insert(queue, { operator1 = op1, operator2 = op2, operator = oper, answer = ans, level = _level, incorrect = 0})
			end			
		elseif (_level == 4) then
			-- double digit multiplication and division
			local count = 5

			for i = count, 1, -1 do
				oper = operators[math.random(3,4)]

				if (oper == '/') then -- no fractions
					op2, ans = math.random(2,20), math.random(2,20)
					op1 = op2 * ans
				else
					op1, op2 = math.random(2,20), math.random(2,20)
				end
				
				a = loadstring('ans = ' .. op1 .. '' .. oper .. '' .. op2)
				a()
				table.insert(queue, { operator1 = op1, operator2 = op2, operator = oper, answer = ans, level = _level, incorrect = 0})
			end
		end

		return queue
	end
}

--- this will handle game logic, key presses etc during play
logic = {
	paused = false,
	problems = {},
	problemsSolved = {},

	font = fonts.neonSmall, 

	-- answer processing
	entry = '',

	newgame = function(self)
		local menu = menu
		menu.enabled = false
		menu.canDismiss = true
		menu.inGame = true
		menu.items = {
			{ text = 'Resume', action = 'gameresumed' },
			{ text = 'Restart', action = 'newgame' }, -- TODO: fix newgame
			{ text = 'Quit', action = 'quit' }
		}

		entities = { menu, messages, logic, dot, starfield }
		callEntities('load', game) -- start with a fresh game object
	end,

	load = function(self, _p)
		self.problems = problems.generate(game.level)
	end,

	draw = function(self)
		local p = self.problems[1]
		local ed = self.entry
		if (ed == '') then ed = '_' end
		local eq = p.operator1 .. ' ' .. p.operator .. ' ' .. p.operator2 .. ' = ' .. ed
		_pfc(eq, colors.white, self.font)
	end,

	keypressed = function(self, _p)
		if (self.paused == true) then return end

		if (string.find('0123456789', _p.k) ~= nil) then
			self.entry = self.entry .. _p.k
		end

		if (_p.k == 'backspace') then
			if (#self.entry == 1) then
				self.entry = ''
			elseif (#self.entry > 1) then
				self.entry = string.sub(self.entry, 1, #self.entry-1)
			end
		end

		if (_p.k == 'return') then
			_m(self.problems[1].answer)
			if (tonumber(self.entry) == self.problems[1].answer) then
				-- clear entry buffer
				self.entry = ''

				-- calculate score
				local points = game.scoreBase * game.scoreMultiplier * self.problems[1].level
				game.score = game.score + points
				game.correct = game.correct + 1

				-- archive and set next problem
				table.insert(self.problemsSolved, self.problems[1])
				table.remove(self.problems, 1)

				if (#self.problems == 0) then
					if (game.level ~= game.levelMax) then
						-- next level
						game.level = game.level + 1
						self.problems = problems.generate(game.level)
					else
						--- beat the game
					end
				end
			else
				game.incorrect = game.incorrect + 1
				self.problems[1].incorrect = self.problems[1].incorrect + 1
			end
		end
	end,

	gamepaused = function(self)
		self.paused = true
	end,

	gameresumed = function(self)
		self.paused = false
	end,

	debug = function(self)
		_m(self.entry .. ' : ' .. self.problems[1].answer)
		_m(game.score)
		_m(game.level)
	end
}

ui = {
	
}