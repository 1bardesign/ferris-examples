--
local state = {}

--multiple feature demos, just nested state machines

function state:enter()
	self.state = state_machine({

	}, "what")
end

function state:update(dt)
	self.state:update(dt)
end

function state:draw()
	self.state:draw()
end

return state
