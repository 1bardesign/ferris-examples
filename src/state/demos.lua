--
local state = {}

--multiple feature demos, just nested state machines

function state:enter()
	self.state = state_machine({
		sprites = require("src.demos.sprites")(self),
	}, "sprites")
end

function state:update(dt)
	self.state:update(dt)
end

function state:draw()
	self.state:draw()
end

return state
