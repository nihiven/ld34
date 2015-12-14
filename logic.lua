-- it's game time
problems = {
	generate = function(_level)
		_level = _level or 1

		local operators = {'+','-','*','/'}
		local queue = {}

		math.randomseed(os.time())

		if (_level == 1) then
			-- single digit addition and subtraction
			local count = 1

			for i = count, 1, -1 do
				oper = operators[math.random(1,2)]
				op1, op2 = math.random(1,9), math.random(1,9)

				if (op1 < op2 and oper == '-') then -- no negative answers
					op1, op2 = op2, op1
				end
				
				a = loadstring('ans = ' .. op1 .. '' .. oper .. '' .. op2)
				a()
				table.insert(queue, { operator1 = op1, operator2 = op2, operator = oper, answer = ans, level = _level, incorrect = 0, age = 0})
			end
		elseif (_level == 2) then
			-- single digit multiplication and division
			local count = 1

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
				table.insert(queue, { operator1 = op1, operator2 = op2, operator = oper, answer = ans, level = _level, incorrect = 0, age = 0})
			end
		elseif (_level == 3) then
			-- double digit addition and subtraction
			local count = 1

			for i = count, 1, -1 do
				oper = operators[math.random(1,2)]
				op1, op2 = math.random(10,99), math.random(10,99)

				if (op1 < op2 and oper == '-') then -- no negative answers
					op1, op2 = op2, op1
				end

				a = loadstring('ans = ' .. op1 .. '' .. oper .. '' .. op2)
				a()
				table.insert(queue, { operator1 = op1, operator2 = op2, operator = oper, answer = ans, level = _level, incorrect = 0, age = 0})
			end			
		elseif (_level == 4) then
			-- double digit multiplication and division
			local count = 1

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
				table.insert(queue, { operator1 = op1, operator2 = op2, operator = oper, answer = ans, level = _level, incorrect = 0, age = 0})
			end
		end

		return queue
	end
}

--- this will handle game logic, key presses etc during play
logic = {
	paused = false,
	gameOver = false,
	problems = {},
	problemsSolved = {},

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

		entities = { menu, messages, ui, logic, dot, starfield }
		callEntities('load', game) -- start with a fresh game object
	end,

	load = function(self, _p)
		self.problems = problems.generate(game.level)
	end,

	update = function(self, _p)
		if (self.paused == true) then return end
		self.problems[1].age = self.problems[1].age + _p.dt
	end,

	draw = function(self)
		local p = self.problems[1]
		local ed = self.entry
		if (ed == '') then ed = '_' end
		local eq = p.operator1 .. ' ' .. p.operator .. ' ' .. p.operator2 .. ' = ' .. ed
		_pfc(eq, colors.white, fonts.large)
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
			if (tonumber(self.entry) == self.problems[1].answer) then
				-- clear entry buffer
				self.entry = ''
				love.event.push('scoremessage', 'Correct answer!')

				-- calculate score as steps so you can add messages
				local points = game.scoreBase 
				points = points * game.scoreMultiplier 
				points = points * self.problems[1].level
				
				if (self.problems[1].age < game.scoreSpeedTime) then 
					points = points * tonumber(game.scoreSpeedMultiplier)
					love.event.push('scoremessage', 'TIME BONUS: +' .. tostring(100*tonumber(game.scoreSpeedMultiplier)) .. '%')
				end

				love.event.push('scoremessage', '+' .. tostring(points))

				game.score = game.score + points
				game.correct = game.correct + 1

				-- archive and remove solved problem
				table.insert(self.problemsSolved, self.problems[1])
				table.remove(self.problems, 1)

				if (#self.problems == 0) then
					if (game.level ~= game.levelMax) then
						-- next level
						game.level = game.level + 1
						self.problems = problems.generate(game.level)
						love.event.push('scoremessage', 'Level up!')
					else
						entities = { summary, starfield }
						callEntities('load')
					end
				end
			else
				game.incorrect = game.incorrect + 1
				self.problems[1].incorrect = self.problems[1].incorrect + 1
				love.event.push('errormessage', 'Wrong answer!')
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
		_m('Answer: ' .. self.problems[1].answer)
		_m('Score: ' .. game.score)
		_m('Level: ' .. game.level)
	end
}

ui = {
	paused = false,
	scoreMessages = {},

	draw = function(self)
		local score = string.rep('0', 6-#tostring(game.score)) .. tostring(game.score)
		local sw = love.graphics.getWidth()

		-- draw stats
		love.graphics.setFont(fonts.large)

		love.graphics.setColor(colors.uiShadow)
		love.graphics.printf('Score: ' .. score, 15+3, 15+3, sw, 'left')
		love.graphics.printf('Level: ' .. game.level, -15+3, 15+3, sw, 'right')

		love.graphics.setColor(colors.ui)
		love.graphics.printf('Score: ' .. score, 15, 15, sw, 'left')
		love.graphics.printf('Level: ' .. game.level, -15, 15, sw, 'right')

		-- draw score messages
		local offset = fonts.large:getHeight()
		for i = #self.scoreMessages, 1, -1 do
			local m = self.scoreMessages[i]

			local c = m.color
			c[4] = m.alpha

			love.graphics.setColor(c)
			love.graphics.printf(m.text, 0, m.y - offset, sw, 'center', 0)
			offset = offset + fonts.large:getHeight()
		end
	end,

	update = function(self, _p)
		if (self.paused == true) then return end

		for i = #self.scoreMessages, 1, -1 do
			local m = self.scoreMessages[i]

			if (m.age <= 0) then 
				self.scoreMessages[i].fade = m.fade - _p.dt
				self.scoreMessages[i].alpha = self.scoreMessages[i].fade * 255
			end

			self.scoreMessages[i].age = m.age - _p.dt
			self.scoreMessages[i].y = m.y - (_p.dt * 100)

			if (m.fade <= 0) then
				table.remove(self.scoreMessages, i)
			end
		end		
	end,

	scoremessage = function(self, _p)
		self.addMessage(self, _p, colors.uiScoreMessage)
	end,

	errormessage = function(self, _p)
		self.addMessage(self, _p, colors.uiErrorMessage)
	end,

	addMessage = function(self, _p, _color)
		local message = { text = _p.text, age = 1, fade = 1, y = 0, scale = 1, color = _color }
		message.y = love.graphics.getHeight() * .4

		table.insert(self.scoreMessages, message)
	end,

	gamepaused = function(self)
		self.paused = true
	end,

	gameresumed = function(self)
		self.paused = false
	end

}