colors = {}
colors.white = { 255, 255, 255 }
colors.black = { 0, 0, 0 }
colors.skyBlue = { 135, 206, 235 }
colors.deepSkyBlue = { 0, 191, 255 }

-- named for game functions
colors.ui = { 7, 80, 110 }
colors.uiShadow = { 175, 175, 175 }
colors.uiScoreMessage = { 253, 126, 0 }
colors.uiErrorMessage = { 253, 0, 0 }

fonts = {
	small = love.graphics.setNewFont('data/neon.ttf', 24),
	large = love.graphics.setNewFont('data/neon.ttf', 128)
}

sounds = {
	intro = love.audio.newSource('data/intro.wav', 'static'),
	launch = love.audio.newSource('data/launch.wav', 'static'),
	lose = love.audio.newSource('data/lose.wav', 'static'),
	menuDown = love.audio.newSource('data/menu_down.wav', 'static'),
	menuUp = love.audio.newSource('data/menu_up.wav', 'static'),
	choose = love.audio.newSource('data/select.wav', 'static'),
	wrong = love.audio.newSource('data/wrong.wav', 'static'),
	keys = love.audio.newSource('data/keys.wav', 'static'),
	correct = love.audio.newSource('data/correct.wav', 'static'),
	glitchRock = love.audio.newSource('data/glitchrock.wav', 'static'),
	win = love.audio.newSource('data/win.wav', 'static')
}
sounds.glitchRock:setVolume(0.1)
