--
local state = {}

--multiple feature demos, just nested state machines

function state:enter()
	self.state = state_machine({
		sprites = require("src.demos.sprites")(self),
		physics = require("src.demos.physics")(self),
	}, "physics")
end

function state:update(dt)
	self.update_start = love.timer.getTime()
	self.state:update(dt)
	self.update_end = love.timer.getTime()
end

function state:draw()
	self.draw_start = love.timer.getTime()
	self.state:draw()
	self.draw_end = love.timer.getTime()
end

function state:draw_ui()
	local total_time =
		(self.update_end - self.update_start)
		+ (self.draw_end - self.draw_start)
	if keyboard:pressed("`") then
		local k = self.state:current_state().k
		local s = k and k.systems
		if not s or not k then
			return
		end
		lg.print(sequence{
			("frame time: %0.2fms"):format(total_time * 1000),
			("sprites:    %d"):format(s.sprite and #s.sprite.sprites or 0),
			("behaviours: %d"):format(s.behaviour and #s.behaviour.all or 0),
		}:concat("\n"))
	else
		lg.print("press ~ for stats")
	end
end

return state
