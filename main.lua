------[[ Ludum Dare #34 - "growing" - the dot ? ]]------

--[[ some variables ]]--
game = { -- all game related values
	debug = true,
	timeLimit = 180,
	timeElapsed = 0,

	load = function()
		entities = { messages, debug, dot, starfield }
	end
}

entities = { menu, messages } -- all game entities
-- messages to the player

colors = {}
colors.white = {255, 255, 255}
colors.black = {0, 0, 0}
colors.skyBlue = {135, 206, 235}
colors.deepSkyBlue = { 0, 191, 255}

-- ui 
ui = {} -- ui 'object'


--[[ Entities ]]--
require 'messages'
require 'starfield'
require 'dot'


------[[  callbacks ]]------
function love.load()
	love.window.setMode(3440, 1440, {fsaa=16, fullscreen=true, resizable=false, vsync=true})

	-- load stuff
	callEntities('load')

	_m('love.load() complete')
end

function love.draw()
	callEntities('draw')
	if (game.debug) then	callEntities('debug')	end
end

function love.update(_dt)
	--- send updates to entities
	game.timeElapsed = game.timeElapsed + _dt
	_m(game.timeElapsed)
	callEntities('update', {dt = _dt})
end


function love.keypressed(_k)
	callEntities('keypressed', {k = _k})
end



------[[ entity functions ]]------
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