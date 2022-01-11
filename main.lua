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

--
game_state = require("src.game_state")

function love.update(dt)
	keyboard:update(dt)
	game_state:update(dt)
end

function love.draw()
	game_state:draw()
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
