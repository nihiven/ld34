starfield = {
	paused = false,
	stars = {},
	moreStars = {},
	load = function(self)
		for i = 1000, 1, -1 do
			local c = math.random(50, 150)
			self.stars[i] = { x = math.random(love.graphics.getWidth()), y = math.random(love.graphics.getHeight()), color = {c, c, c} }
		end

		for i = 500, 1, -1 do
			local c = math.random(50, 150)
			self.moreStars[i] = { x = math.random(love.graphics.getWidth()), y = math.random(love.graphics.getHeight()), color = {c, c, c} }
		end

	end,

	draw = function(self)
		for i = #self.stars, 1, -1 do
			if (math.random(0,1000) > 999) then
				local c = math.random(25, 100)
				self.stars[i].color = {c, c, c}
			end

			love.graphics.setColor(self.stars[i].color)
			love.graphics.circle('fill', self.stars[i].x, self.stars[i].y, 1, 64)
		end

		-- moooore stars
		for i = #self.moreStars, 1, -1 do
			if (math.random(0,1000) > 999) then
				local c = math.random(25, 100)
				self.moreStars[i].color = {c, c, c}
			end

			love.graphics.setColor(self.moreStars[i].color)
			love.graphics.circle('fill', self.moreStars[i].x, self.moreStars[i].y, 1, 64)
		end
	end,

	update = function(self, _p)
		for i = #self.moreStars, 1, -1 do
			self.moreStars[i].x = self.moreStars[i].x + _p.dt * 3
			self.moreStars[i].y = self.moreStars[i].y + _p.dt * 2
		end
	end,

	gamepaused = function(self)
		self.paused = true
	end,

	gameresumed = function(self)
		self.paused = false
	end
}

