return function(systems, args)
	local e = ferris.entity(systems)

	local body = e:add_component("physics", "body", {
		pos = args.pos:copy(),
		vel = args.vel:copy(),
		acc = vec2(0, 200),
		radius = 3.5,
		bounce = 0.5,
		ground_friction = 0.2,
		air_friction = 0.1,
	})

	--float in water
	e:add_component("behaviour", "float", require("src.demos.physics.float")(
		e,
		body,
		vec2(0, -10)
	))

	local sprite = e:add_component("sprite", "sprite", {
		texture = assets.image.ball,
		layout = vec2(1,2),
		frame = vec2(0, love.math.random(0, 1)),
		rot = love.math.random() * math.tau,
	})
	sprite.pos = body.pos --bind directly to body

	--make the sprite roll as it moves horizontally
	--we don't actually have any rolling physics :)
	e:add_component("behaviour", "roll sprite", {
		update = function(self, dt)
			sprite.rot = sprite.rot + body.vel.x / (math.tau * math.max(1, body.radius)) * 3 * dt
		end,
	})

	--shrink to nothing and then vanish
	e:add_component("behaviour", "shrink to nothing", {
		timer = timer(20),
		start_radius = body.radius,
		start_size = sprite.size:copy(),
		update = function(self, dt)
			self.timer:update(dt)
			if self.timer:expired() then
				e:destroy()
			end
			local f = math.clamp01(math.lerp(-3, 1, self.timer:progress()))
			body.radius = math.lerp(self.start_radius, 0, f)
			sprite.size = self.start_size:lerp(vec2(0, 0), f)
		end,
	})

	return e
end
