menu = {
	enabled = true,
	canDismiss = false,
	inGame = false,
	selected = 1,
	font = fonts.heavyLarge, 
	items = {
		{ text = 'THE DOT', action = 'newgame' },
		{ text = 'quit', action = 'quit' }
	},

	draw = function(self)
		if (self.enabled == false) then return end

		local y = _scrMid().y - (#self.items / 2 * self.font:getHeight())

		love.graphics.setFont(self.font)

		for key,value in pairs(self.items) do
			local color = colors.white
			if (self.selected == key) then color = colors.skyBlue end
			_pf(self.items[key].text, 0, y, love.graphics.getWidth(), 'center', color)
			y = y + self.font:getHeight()
		end
	end,

	keypressed = function(self, _p)
		if (_p.k == 'escape') then
			if (self.enabled == true and self.canDismiss == true) then
				self.enabled = false
				love.event.push('menuclose')
				if (self.inGame == true) then love.event.push('gameresumed') end
			elseif (self.enabled == false) then
				self.enabled = true
				love.event.push('menuopen')
				if (self.inGame == true) then love.event.push('gamepaused') end
			end
		end

		-- the rest of these should not be checked if not enabled
		if (self.enabled == false) then return end

		if (_p.k == 'up' and self.selected > 1) then
			self.selected = self.selected - 1
		elseif (_p.k == 'down' and self.selected < #self.items) then
			self.selected = self.selected + 1
		elseif (_p.k == 'return') then
			love.event.push(self.items[self.selected].action)
		end
	end,

	menuopen = function(self, _p)
		self.enabled = true
	end,

	menuclose = function(self)
		self.enabled = false
	end,

	gameresumed = function(self)
		self.enabled = false
	end,

	newgame = function()
		logic.newgame()
	end
}