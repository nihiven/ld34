dot = {
	paused = false,
	rotation = 0,

	load = function(self, _g)
		self.radius = 1
		self.x = love.graphics.getWidth() * 0.9
		self.y = love.graphics.getHeight() * 0.9
		self.xFinal = love.graphics.getWidth() / 2
		self.yFinal = love.graphics.getHeight() / 2
		self.xTravel = self.x - self.xFinal
		self.yTravel = self.y - self.yFinal
		self.xStep = self.xTravel / _g.timeLimit
		self.yStep = self.yTravel / _g.timeLimit 
		
		self.scaleFactor = 1

		self.radiusMax = love.graphics.getWidth() * 0.55
		self.radiusStep = self.radiusMax / _g.timeLimit

		-- for image
		--self.image = love.graphics.newImage('data/blackhole.png')
	end,

	draw = function(self)
		-- draw a nice circle
		love.graphics.setColor(colors.black)
		--love.graphics.setColor({100,100,100})
		love.graphics.circle('fill', self.x, self.y, self.radius, 4096)

		--- draw earth
		love.graphics.setColor(colors.white)
		self.offset = (self.scaleFactor * ((love.graphics.getWidth() / 778) * 778)) / 2
		--love.graphics.draw(self.image, self.x, self.y, self.rotation, self.scaleFactor, self.scaleFactor, 997, 573.5)
		--love.graphics.draw(self.image, self.x, self.y, self.rotation, self.scaleFactor, self.scaleFactor, 389, 389)
	end,

	update = function(self, _p)
		if (self.paused == true) then return end

		local fps = love.timer.getFPS()
		self.x = self.x - (self.xStep * _p.dt)
		self.y = self.y - (self.yStep * _p.dt)
		self.radius = self.radius + (self.radiusStep * _p.dt)

		-- for image
		self.scaleFactor = (_p.g.timeElapsed / _p.g.timeLimit) * (love.graphics.getWidth() / 778)

		self.rotation = self.rotation + _p.dt
	end,

	gamepaused = function(self)
		self.paused = true
	end,

	gameresumed = function(self)
		self.paused = false
	end,

	debug = function(self, _q)
		_m(self.offset)
		_m(self.radius .. ' of ' .. self.radiusMax .. ' at ' .. self.x .. ',' .. self.y)
	end

}