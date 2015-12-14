------[[ Ludum Dare #34 - "growing" - the dot ? ]]------
debug = false

--[[ Entities ]]--
require('colors')
require('messages')
require('game')
require('starfield')
require('dot')
require('menu')
require('logic')


summary = {
	draw = function(self)
		local sw = love.graphics.getWidth()
		local offset = fonts.large:getHeight()

		love.graphics.setFont(fonts.large)
		love.graphics.setColor(colors.uiScoreMessage)

		local messages = {}
		if (game.won == true) then
			messages = {'You Won!', 'Score: ' .. game.score }
		else
			messages = {'The dot ate you!', 'Score: ' .. game.score }
		end

		for i = #messages, 1, -1 do
				love.graphics.printf(messages[i], 0, offset*i, sw, 'center')
		end
	end
}


-- initial entities
entities = { menu, messages, starfield } -- all game entities

------[[ Love callbacks ]]------
function love.load()
	love.window.setMode(3440, 1440, { fsaa=8, fullscreen=true, resizable=false, vsync=true })

	-- load stuff
	callEntities('load', game)
end

function love.draw()
	callEntities('draw')

	if (debug == true) then 
		_m(game.timeElapsed)
		callEntities('debug')
	end
end

function love.update(_dt)
	--- send updates to entities
	game.timeElapsed = game.timeElapsed + _dt
	callEntities('update', {dt = _dt, g = game})
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

function love.handlers.scoremessage(_text)
	callEntities('scoremessage', {text = _text})
end

function love.handlers.errormessage(_text)
	callEntities('errormessage', {text = _text})
end

function love.handlers.gamewon()
	callEntities('gamewon', true)
end

function love.handlers.gamelost()
	callEntities('gamelost', false)
end

------[[ entity functions ]]------
function callEntities(_f, _p)
	-- check for and call each entity's _f 
	for i = #entities, 1, -1 do
		if (entities[i][_f] ~= nil) then
			entities[i][_f](entities[i], _p)
		end		
	end
end


------[[ helper functions ]]------
function _pf(_text, _x, _y, _w, _align, _color, _font)
	local offset = 0

	if (_font ~= nil) then 
		love.graphics.setFont(_font)
		offset = _font:getHeight() / 2
	end
	
	_sc(_color)
	love.graphics.printf(_text, _x, _y - offset, _w, _align)
end

function _sc(_color)
	love.graphics.setColor(_color)
end

function _pfc(_text, _color, _font)
	_pf(_text, 0, _scrMid().y, love.graphics.getWidth(), 'center', _color, _font)
end

function _scrMid()
	return {x = love.graphics.getWidth() / 2, y = love.graphics.getHeight() / 2}
end

function _m(_t, _d)
	_d = _d or false
	messages.add(messages, _t, _d)
end