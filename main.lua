--[[
	main entry point for love

	basically set up the main loop, game state, and input hooks and then be on our way!
]]

--pull in deps
require("lib.batteries"):export()
--expose ferris globally
ferris = require("lib.ferris")

--set up main loop
ferris.main_loop()

--shorthand
lg = love.graphics

--todo: unify some kind of centralised input that can add its own hooks
--	ideally ferris-side
keyboard = ferris.keyboard()

function love.keypressed(k)
	--allow ctrl+r for reset, and ctrl+q for quit, no matter what
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

--set up the global shared game state
game_state = require("src.game_state")

function love.update(dt)
	--update input
	keyboard:update(dt)
	--update the game
	game_state:update(dt)
	--flush any destroyed entities
	ferris.entity.flush_entities()
end

function love.draw()
	--just draw the game state
	game_state:draw()
end
