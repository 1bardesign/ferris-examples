local physics_demo = class()

--for the demo state ui
physics_demo.name = "physics and platforming"
physics_demo.description = ([[
	an example physics system and a player avatar
	(wasd or arrows to move)
]]):dedent()

--setup
function physics_demo:new(parent)
	self.k = ferris.kernel()
		:add_system("bg_tiles", require("src.systems.tile_system"){
			map = assets.map.physics,
			layer = "bg",
			image = assets.image.tiles,
			tilesize = vec2(8, 8),
		})
		:add_system("behaviour", ferris.systems.behaviour_system())
		:add_system("sprite", ferris.systems.sprite_system())
		:add_system("animation", ferris.systems.animation_system())
		:add_system("tiles", require("src.systems.tile_system"){
			map = assets.map.physics,
			layer = "fg",
			image = assets.image.tiles,
			tilesize = vec2(8, 8),
		})
		:add_system("physics", require("src.systems.physics_system")())

	local collisions = require("src.load_objects")(assets.map.physics, "collision")
	for _, v in ipairs(collisions) do
		self.k.systems.physics:add_level_geo(v.a, v.b)
	end

	local water = require("src.load_objects")(assets.map.physics, "water")
	for _, v in ipairs(water) do
		self.k.systems.physics:add_zone(v.pos, v.halfsize, "water")
	end

	local objects = require("src.load_objects")(assets.map.physics, "objects")
	local function fetch_object(name)
		return functional.find_match(objects, function(v)
			return v.name == name
		end)
	end

	--create player
	require("src.demos.physics.player")(self.k.systems, {
		pos = fetch_object("player").pos,
	})

	--create dispenser
	require("src.demos.physics.dispenser")(self.k.systems, {
		spawn = fetch_object("dispenser"),
		path = fetch_object("dispenser path"),
	})
end

function physics_demo:update(dt)
	self.k:update(dt)
end
function physics_demo:draw()
	self.k:draw()
end

return physics_demo
