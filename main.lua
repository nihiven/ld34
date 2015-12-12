------[[ Ludum Dare #34 - "growing" - the dot ? ]]------

--[[ some variables ]]--
g = { -- all game related values
	debug = true,
	time = {
		now = 1000, -- 1 is game over
		factor = .1, -- time decrease factor
		tick = 0
	}
}

entities = {} -- all game entities
-- messages to the player
messages = {
	queue = {},
	
	add = function(self, _t, _d)
		table.insert(self.queue, {duration = 2, drawn = false, text = _t, destroy = _d})
	end,
	
	draw = function(self)
		local y = 10
		for i = #self.queue, 1, -1 do
			_sc(colors.white)
			love.graphics.printf(self.queue[i].text, 10, y, love.window.getWidth(), "left")
			self.queue[i].drawn = true
			y = y + 20
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

colors = {}
colors.white = {255, 255, 255}
colors.black = {0, 0, 0}
colors.skyBlue = {135, 206, 235}
colors.deepSkyBlue = { 0, 191, 255}

-- ui 
ui = {} -- ui 'object'


--[[ Entities ]]--
require 'starfield'
require 'dot'
require 'debug'

------[[ Love callbacks ]]------
function love.load()
	--love.window.setMode(3440, 1440, {fsaa=16, fullscreen=true, resizable=false, vsync=true})

	-- load stuff
	-- eventually: ui.font = love.graphics.setNewFont("font.ttf", 18)	

	-- test junk below
	table.insert(entities, starfield)
	table.insert(entities, dot)
	table.insert(entities, debug)
	table.insert(entities, messages)

	callEntities('load')
	_m('love.load() complete')
end

function love.draw()
	callEntities('draw')
	if (g.debug) then	callEntities('debug')	end
end

function love.update(_dt)
	g.time.now = g.time.now + _dt

	--- send updates to entities
	callEntities('update', {dt = _dt})
end



------[[ game functions ]]------
function callEntities(_f, _p)
	-- check for and call each entity's draw()
	for i = #entities, 1, -1 do
		if (entities[i][_f] ~= nil) then
			entities[i][_f](entities[i], _p)
		end		
	end
end



------[[ helper functions ]]------
function _pf(_text, _x, _y, _w, _align, _color)
	_sc(_color)
	love.graphics.printf(_text, _x, _y, _w, _align)
end

function _sc(_color)
	love.graphics.setColor(_color)
end

function _scrMid()
	return {x = love.graphics.getWidth() / 2, y = love.graphics.getHeight() / 2}
end

function _m(_t, _d)
	_d = _d or false
	messages.add(messages, _t, _d)
end