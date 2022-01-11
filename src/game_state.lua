--ultra basic game state management

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

--upscale shared "screens"
local game_factor = 2
local game_zoom = 2
local ui_factor = 2
local ui_zoom = 1
game_canvas = lg.newCanvas(
	lg.getWidth() / game_factor,
	lg.getHeight() / game_factor
)
ui_canvas = lg.newCanvas(
	lg.getWidth() / ui_factor,
	lg.getHeight() / ui_factor
)
game_canvas:setFilter("nearest", "nearest")
ui_canvas:setFilter("nearest", "nearest")

--start off black, fade in
game_state.fade:flash(0xff000000, 0.1)

function game_state:update(dt)
	self.async:update_for_time(1e-3, true)
	self.fade:update(dt)
	self.states:update(dt)
end

function game_state:draw()
	lg.push("all")
		lg.push()
			lg.scale(game_zoom)
			lg.setCanvas(game_canvas)
			lg.clear(lg.getBackgroundColor())
			self.states:draw()
		lg.pop()

		lg.push()
			lg.scale(ui_zoom)
			lg.setCanvas(ui_canvas)
			lg.clear(0, 0, 0, 0)
			self.states:_call("draw_ui")
		lg.pop()
	lg.pop()

	lg.push("all")
		lg.setBlendMode("alpha", "premultiplied")
		lg.draw(game_canvas, 0, 0, 0, game_factor)
		lg.draw(ui_canvas, 0, 0, 0, ui_factor)
	lg.pop()

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
