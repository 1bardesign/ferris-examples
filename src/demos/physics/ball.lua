return function(systems, args)
	local e = ferris.entity(systems)

	local img = assets.image.dispenser

	local body = e:add_component("physics", "body", {
		pos = args.pos:copy(),
		vel = args.vel:copy(),
		acc = vec2(0, 100),
		radius = 4,
		bounce = 0.5,
	})

	local sprite = e:add_component("sprite", "sprite", img)
	sprite.size = vec2(10, 10)
	sprite.framesize = sprite.size:scalar_div(img:getDimensions())
	sprite.frame:scalar_set(3, 0)
	sprite.pos = body.pos --bind directly to body

	e:add_component("behaviour", "roll_sprite", {
		update = function(self, dt)
			sprite.rot = sprite.rot + body.vel.x / (math.tau * math.max(1, body.radius)) * dt
		end,
	})

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
