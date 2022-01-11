local sprite_demo = class({})

function sprite_demo:new(parent)
	self.k = ferris.kernel()
		:add_system("behaviour", ferris.systems.behaviour_system)
		:add_system("sprite", ferris.systems.sprite_system)
		:add_system("animation", ferris.systems.animation_system)
end

function sprite_demo:update(dt) end
function sprite_demo:draw() end

return sprite_demo
