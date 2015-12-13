menu = {
	enabled = true,
	canDismiss = false,
	selected = 1,
	font = love.graphics.setNewFont('neon.ttf', 128), 
	items = {
		{ text = 'THE DOT', action = game['load'] },
		{ text = 'quit', action = love.event['quit'] }
	},

	load = function(self)
		entities = { self, messages }
	end,

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
		if (self.enabled == false) then return end

		if (_p.k == 'up' and self.selected > 1) then
			self.selected = self.selected - 1
		elseif (_p.k == 'down' and self.selected < #self.items) then
			self.selected = self.selected + 1
		elseif (_p.k == 'return') then
			local item = self.items[self.selected]['action']()
		elseif (_p.k == 'escape' and self.canDismiss == true) then
			self.enabled = false
		end
	end
}