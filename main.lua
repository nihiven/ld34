------[[ Ludum Dare #34 - "growing" - the dot ? ]]------
debug = true

--[[ Entities ]]--
require('colors')
require('messages')
require('game')
require('starfield')
require('dot')
require('menu')

-- it's game time
problems = {}

--- this will handle game logic, key presses etc during play
logic = {
	paused = false,

	newgame = function(self)
		local m = menu
		m.enabled = false
		m.canDismiss = true
		m.inGame = true
		m.items = {
			{ text = 'Restart', action = 'newgame' },
			{ text = 'Quit', action = 'quit' }
		}

		entities = { m, messages, dot, starfield, logic }
		callEntities('load', game) -- start with a fresh game object
	end,

	gamepaused = function(self)
		self.paused = true
	end,

	gameresumed = function(self)
		self.paused = false
	end
}

-- initial entities
entities = { menu, messages, logic } -- all game entities

------[[ Love callbacks ]]------
function love.load()
	love.window.setMode(3440, 1440, {fsaa=16, fullscreen=true, resizable=false, vsync=true})

	-- load stuff
	callEntities('load', game)

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

-- custom events
function love.handlers.menuopen()
	callEntities('menuopen')
end

function love.handlers.menuclose()
	callEntities('menuclose')
end

function love.handlers.gamepaused()
	callEntities('gamepaused')
end

function love.handlers.gameresumed()
	callEntities('gameresumed')
end

function love.handlers.newgame()
	callEntities('newgame')
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