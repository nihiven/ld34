dot = {
	x = -100,
	y = -75,

	------[[ dot functions ]]------
	load = function(self)
		self.maxRadius = love.graphics.getWidth() * 1.1
		self.radius = 1
		self.x = love.graphics.getWidth() * 0.9
		self.y = love.graphics.getHeight() * 0.9
	end,

	draw = function(self)
		love.graphics.setColor(colors.skyBlue)
		love.graphics.circle('fill', self.x, self.y, self.radius, 4096)
	end,

	update = function(self, _p)
		self.radius = self.radius + _p.dt
		self.x = self.x - _p.dt / 2
		self.y = self.y - _p.dt / 2 
	end,

	debug = function(self, _q)
		_m(self.radius .. ' of ' .. self.maxRadius .. ' at ' .. self.x .. ',' .. self.y,true)
	end

}