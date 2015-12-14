colors = {}
colors.white = { 255, 255, 255 }
colors.black = { 0, 0, 0 }
colors.skyBlue = { 135, 206, 235 }
colors.deepSkyBlue = { 0, 191, 255 }

-- named for game functions
colors.ui = { 7, 80, 110, 255 }
colors.uiShadow = { 175, 175, 175, 50 }
colors.uiScoreMessage = { 253, 126, 0, 255 }
colors.uiErrorMessage = { 253, 0, 0, 255 }

fonts = {
	small = love.graphics.setNewFont('data/neon.ttf', 24),
	large = love.graphics.setNewFont('data/neon.ttf', 128)
	--small = love.graphics.setNewFont('data/heavy_data.ttf', 24),
	--large = love.graphics.setNewFont('data/heavy_data.ttf', 128)
}