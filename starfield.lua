starfield = {
	stars = {},
	load = function(self)
		for i = 1000, 1, -1 do
			local c = math.random(50, 150)
			self.stars[i] = { x = math.random(love.graphics.getWidth()), y = math.random(love.graphics.getHeight()), color = {c, c, c} }
		end
	end,

	draw = function(self)
		for i = #self.stars, 1, -1 do
			if (math.random(0,1000) > 999) then
				local c = math.random(25, 100)
				self.stars[i].color = {c, c, c}
			end

			love.graphics.setColor(self.stars[i].color)
			love.graphics.circle('fill', self.stars[i].x, self.stars[i].y, 1, 16)
		end
	end
}

