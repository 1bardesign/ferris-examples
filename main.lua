--pull in deps
require("lib.batteries"):export()
ferris = require("lib.ferris")

--set up main loop
ferris.main_loop()

--shorthand
lg = love.graphics

--todo: unify some kind of centralised input that can add its own hooks
--	ideally ferris-side
keyboard = ferris.keyboard()

--upscale shared canvas
local scale_factor = 2
screen_canvas = lg.newCanvas(
	lg.getWidth() / scale_factor,
	lg.getHeight() / scale_factor
)
screen_canvas:setFilter("nearest", "nearest")

--
game_state = require("src.game_state")

function love.update(dt)
	keyboard:update(dt)
	game_state:update(dt)
end

function love.draw()
	lg.push("all")
	lg.setCanvas(screen_canvas)
	lg.clear(lg.getBackgroundColor())
	game_state:draw()
	lg.pop()
	lg.push("all")
	lg.setBlendMode("alpha", "premultiplied")
	lg.scale(2)
	lg.draw(screen_canvas)
	lg.pop()
end

function love.keypressed(k)
	if love.keyboard.isDown("lctrl", "rctrl") then
		if k == "r" then
			love.event.quit("restart")
		elseif k == "q" then
			love.event.quit()
		end
	end
	keyboard:keypressed(k)
end

function love.keyreleased(k)
	keyboard:keyreleased(k)
end
