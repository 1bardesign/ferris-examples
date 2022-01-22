return function(systems, args)
	local e = ferris.entity(systems)

	local row = love.math.random(0, 1)

	local sprite = e:add_component("sprite", "sprite", {
		texture = assets.image.human,
		layout = vec2(6, 2),
		frame = vec2(0, row),
		pos = args.pos,
		--position at feet
		offset = vec2(0, -6),
		--random facing direction
		x_flipped = love.math.random() < 0.5,
		--just behind seats
		z = 0.5,
	})

	e:add_component("behaviour", "randomly turn", {
		update = function(self, dt)
			--small chance each frame to turn
			if love.math.random() < 0.001 then
				sprite.x_flipped = not sprite.x_flipped
			end
		end,
	})

	return e
end
