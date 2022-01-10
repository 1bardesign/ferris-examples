--untra basic game state management

--global
game_state = {
	fade = ferris.screen_overlay(),
	async = async(),
	current_transition = false,
	states = state_machine(
		{
			load = require("src.state.load"),
			title = require("src.state.title"),
			demos = require("src.state.demos"),
		},
		--start in load state
		"load"
	)
}

--start off black, fade in
game_state.fade:flash(0xff000000, 0.1)

function game_state:update(dt)
	self.async:update_for_time(1e-3, true)
	self.fade:update(dt)
	self.states:update(dt)
end

function game_state:draw()
	self.states:draw()
	self.fade:draw()
end

function game_state:transition(to_state)
	if self.current_transition then
		return
	end
	self.current_transition = to_state
	local duration = 0.25
	local duration_ratio = 0.25
	self.fade:fade(0xff000000, duration * duration_ratio)
	self.async:call(function()
		while not self.fade:done() do
			async.stall()
		end
		self.states:set_state(to_state)
		self.current_transition = false
		self.fade:fade(0x00000000, duration * (1 - duration_ratio))
	end)
end

return game_state
