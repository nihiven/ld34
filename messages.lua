messages = {
	queue = {},
	font = love.graphics.setNewFont('neon.ttf', 24),

	add = function(self, _t, _d)
		_d = _d or true
		table.insert(self.queue, {duration = 2, drawn = false, text = _t, destroy = _d})
	end,
	
	draw = function(self)
		local y = 10

		love.graphics.setFont(self.font)
		for i = #self.queue, 1, -1 do
			_sc(colors.white)
			love.graphics.printf(self.queue[i].text, 10, y, love.window.getWidth(), "left")
			self.queue[i].drawn = true
			y = y + self.font:getHeight()
		end
	end,

	update = function(self, _p)
		for i = #self.queue, 1, -1 do
			self.queue[i].duration = self.queue[i].duration - _p.dt
			if (self.queue[i].duration <= 0 or (self.queue[i].destroy and self.queue[i].drawn)) then 
				table.remove(self.queue, i)
			end
		end
	end
} 
