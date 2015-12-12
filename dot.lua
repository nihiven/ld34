dot = {

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
		
		self.radiusMax = love.graphics.getWidth() * 0.55
		self.radiusStep = self.radiusMax / _g.timeLimit

	end,

	draw = function(self)
		love.graphics.setColor(colors.skyBlue)
		love.graphics.circle('fill', self.x, self.y, self.radius, 4096)
	end,

	update = function(self, _p)
		local fps = love.timer.getFPS()
		self.x = self.x - (self.xStep * _p.dt)
		self.y = self.y - (self.yStep * _p.dt)
		self.radius = self.radius + (self.radiusStep * _p.dt)
	end,

	debug = function(self, _q)
		_m(self.radius .. ' of ' .. self.radiusMax .. ' at ' .. self.x .. ',' .. self.y,true)
	end

}