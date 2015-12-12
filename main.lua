------[[ Ludum Dare #34 - "growing" - the dot ? ]]------

--[[ some variables ]]--
g = { -- all game related values
	time = {
		now = 100, -- 100 is starting, 1 is game over
		factor = 10, -- time increase factor
		tick = 0
	}
}

entities = {} -- all game entities
messages = {} -- messages to the player

colors = {}
colors.white = {255, 255, 255}
colors.black = {0, 0, 0}
colors.skyBlue = {135, 206, 235}
colors.deepSkyBlue = { 0, 191, 255}

-- the dot
dot = {
	maxRadius = 1000,
}

-- ui 
ui = {} -- ui 'object'



------[[ Love callbacks ]]------
function love.load()
	-- ui
	ui.scr = 
	{
		width = love.graphics.getWidth(),
		height = love.graphics.getHeight(),
		midX = love.graphics.getWidth() / 2,
		midY = love.graphics.getHeight() / 2
	}

	-- load stuff
	-- eventually: ui.font = love.graphics.setNewFont("font.ttf", 18)	

	-- test junk below
	table.insert(entities, dot)
end

function love.draw()
	drawEntities()

	-- test junk
	drawDebug()
end

function love.update(dt)
	-- i think we'll control the global time value here.
	-- this will control all movement and will be 1-100?
	g.time.tick = globals

	--- send updates to entities
	updateEntities(love.timer.getTime(), love.timer.getDelta())
end



------[[ game functions ]]------
function drawEntities()
	-- check for and call each entity's draw()
	for i = #entities, 1, -1 do
		if (entities[i].draw ~= nil) then
			entities[i].draw()
		end		
	end
end

function updateEntities(_t, _dt)
	-- check for and call each entity's draw()
	for i = #entities, 1, -1 do
		if (entities[i].update ~= nil) then
			entities[i].update(_t, _dt)
		end
	end
end


------[[ entity functions ]]------
function dot.draw()
	-- determine sized based on g.time
	local radius = dot.maxRadius / g.time.now


	-- draw the dot
	_sc(colors.skyBlue)
	love.graphics.circle('fill', ui.scr.midX, ui.scr.midX, radius, 512)
	_sc(colors.deepSkyBlue)
	love.graphics.circle('fill', ui.scr.midX, ui.scr.midX, radius-(5 / g.time.now), 512)
	
end

function dot.update(_t, _dt)
	
end



------[[ helper functions ]]------
function _pf(_text, _x, _y, _w, _align, _color)
	_sc(_color)
	love.graphics.printf(_text, _x, _y, _w, _align)
end

function _sc(_color)
	love.graphics.setColor(_color)
end



------[[ debug functions ]]------
function drawDebug()
	if (g.debug == false) then return end

	_pf(love.timer.getFPS(), 10, 10, 100, "left", colors.white)
--	_pf(g.time.now, 10, 30, 100, "left", colors.white)
--	_pf(g.time.tick, 10, 50, 100, "left", colors.white)
end

		


