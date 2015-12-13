starfield = {
	screenScale = 1,
	paused = false,
	stars = {},
	load = function(self)
		self.screenScale = love.graphics.getHeight() / love.graphics.getWidth()

		for i = 10000, 1, -1 do
			local c = math.random(20, 175)
			self.stars[i] = { x = math.random(0-(love.graphics.getWidth()*.50),love.graphics.getWidth()*1.5), y = math.random(0-(love.graphics.getHeight()*.50),love.graphics.getHeight()*1.5), color = {c, c, c} }
			self.stars[i].scale = math.random(-5000,5000) / 100000
		end
	end,

	draw = function(self)
		for i = #self.stars, 1, -1 do
			local color = self.stars[i].color
			
			if (math.random(1,1000) > 999) then
				color = {25, 40, 2}
			end

			love.graphics.setColor(color)
			love.graphics.circle('fill', self.stars[i].x, self.stars[i].y, 1, 64)
		end
	end,

	update = function(self, _p)
		for i = #self.stars, 1, -1 do
			self.stars[i].x = self.stars[i].x + self.stars[i].scale
			self.stars[i].y = self.stars[i].y + self.stars[i].scale

--			self.stars[i].x = self.stars[i].x + (_p.dt * self.stars[i].scale / 1000)
	--		self.stars[i].y = self.stars[i].y + (_p.dt * self.stars[i].scale/ 1000)
		end
	end,

	gamepaused = function(self)
		self.paused = true
	end,

	gameresumed = function(self)
		self.paused = false
	end
}

