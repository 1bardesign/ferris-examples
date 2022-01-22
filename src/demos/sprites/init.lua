local sprite_demo = class({})

--for the demo state ui
sprite_demo.name = "sprites and entities"
sprite_demo.description = ([[
	complex sprite management and lots of particle spam
	(space to add an extra firework)
]]):dedent()

--setup
function sprite_demo:new(parent)
	self.k = ferris.kernel()
		--tilemap layer
		:add_system("tiles", require("src.systems.tile_system"){
			map = assets.map.sprites,
			image = assets.image.tiles,
			tilesize = vec2(8, 8),
		})
		--arbitrary behaviours
		:add_system("behaviour", ferris.systems.behaviour_system())
		--2d z sorted sprites
		:add_system("sprite", ferris.systems.sprite_system())
		--sprite animation management
		:add_system("animation", ferris.systems.animation_system())

	--create the ferris wheel entity, which handles the fireworks and all the rest
	require("src.demos.sprites.wheel")(self.k.systems, {
		pos = vec2(21, 8):scalar_mul_inplace(8),
	})
end

function sprite_demo:update(dt)
	self.k:update(dt)
end
function sprite_demo:draw()
	self.k:draw()
end

return sprite_demo
