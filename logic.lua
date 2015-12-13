-- it's game time
problems = {
	generate = function(_count, _difficulty)
		_count = _count or 1
		_difficulty = _difficulty or 1

		local operators = {'+','-','*','/'}
		local queue = {}

		math.randomseed(os.time())
		for i = _count, 1, -1 do
			local oper = operators[math.random(1,4)]

			if (oper == '/') then -- no fractions
				op2, ans = math.random(1,9), math.random(1,9)
				op1 = op2 * ans
			else
				op1, op2 = math.random(1,9), math.random(1,9)

				if (op1 < op2 and oper == '-') then -- no negative answers
					op1, op2 = op2, op1
				end

				a = loadstring('ans = ' .. op1 .. '' .. oper .. '' .. op2)
				a()
			end
			
			table.insert(queue, { operator1 = op1, operator2 = op2, operator = oper, answer = ans, difficulty = _difficulty })
		end

		return queue
	end
}

--- this will handle game logic, key presses etc during play
logic = {
	paused = false,
	problems = {},
	problemsSolved = {},

	font = love.graphics.setNewFont('neon.ttf', 128), 

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
		self.problems = problems.generate(game.levelProblems, game.level)
	end,

	draw = function(self)
		local p = self.problems[1]
		local eq = p.operator1 .. ' ' .. p.operator .. ' ' .. p.operator2 .. ' = ' .. self.entry

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
				self.entry = ''
				table.insert(self.problemsSolved, self.problems[1])
				table.remove(self.problems, 1)
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
	end
}

ui = {
	
}