return function(systems, args)
	local e = ferris.entity(systems)

	local img = assets.image.human
	local sheet_row = table.pick_random({0, 1})

	local sprite = e:add_component("sprite", "sprite", img)
	sprite.framesize:sset(1):sdivi(2, 2)
	sprite.frame:sset(0, sheet_row)
	sprite.size:vmuli(sprite.framesize)
	sprite.pos:vset(args.pos)
	--position at feet
	sprite.offset.y = -6
	sprite.x_flipped = love.math.random() < 0.5
	--just behind seats
	sprite.z = 0.5

	return e
end
