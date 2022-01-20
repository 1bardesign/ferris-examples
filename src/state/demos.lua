--
local state = {}

--multiple feature demos, just nested state machines

local demo_states = {
	"sprites",
	"physics",
}

function state:enter()
	local _loaded_states = {}
	for _, v in ipairs(demo_states) do
		_loaded_states[v] = require("src.demos."..v)(self)
	end

	self.state = state_machine(_loaded_states, table.front(demo_states))
end

function state:update(dt)
	if keyboard:just_pressed("escape") then
		return "title"
	end

	local state_index = table.index_of(demo_states, self.state.current_state_name)
	local old_state_index = state_index
	if
		keyboard:just_pressed("pagedown")
		or (keyboard:just_pressed("tab") and keyboard:pressed("lshift"))
	then
		state_index = state_index + 1
	end
	if
		keyboard:just_pressed("pageup")
		or (keyboard:just_pressed("tab") and keyboard:released("lshift"))
	then
		state_index = state_index - 1
	end
	if old_state_index ~= state_index then
		local target_state = demo_states[math.wrap_index(state_index, demo_states)]
		if target_state then
			self.state:set_state(target_state)
		end
	end

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
		+ 1e-3 --for manual_gc time in main_loop
	local current_state = self.state:current_state()
	lg.push()
	local line_height = lg.getFont():getHeight()
	local margin = 4
	local lines = 4
	lg.translate(margin, ui_canvas:getHeight() - line_height * lines - margin)
	if keyboard:pressed("`") then
		local k = current_state.k
		local s = k and k.systems
		if not s or not k then
			return
		end
		lg.push()
		lg.print("system components active:")
		lg.translate(20, line_height)
		for i, v in ipairs({
			{"sprite",    "sprites",     "sprites"},
			{"behaviour", "behaviours",  "all"},
			{"physics",   "bodies",      "all"},
		}) do
			local system_name, component_name, collection = unpack(v)
			if s[system_name] then
				lg.print(("%s: %d"):format(component_name, #s[system_name][collection]))
				lg.translate(120, 0)
			end
		end
		lg.pop()
		lg.translate(0, line_height * 2)
		lg.push()
		lg.translate(20, 0)
		lg.print(("frame time: %0.2fms (%d fps)"):format(total_time * 1000, 1 / math.max(0.001, total_time)))
		lg.translate(0, line_height)
		lg.print(("memory: %0.2fmb"):format(collectgarbage("count") / 1024, lg.getStats().texturememory / 1024 / 1024))
		lg.pop()
	else
		lg.print(sequence{
			("demo: %s"):format(current_state.name),
			("%s"):format(current_state.description),
			"(press ~ for stats, tab to switch demo)"
		}:concat("\n"))
	end
	lg.pop()
end

return state
