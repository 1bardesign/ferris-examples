return function(systems, args)
	local e = ferris.entity(systems)

	local img = assets.image.human

	local body = e:add_component("physics", "body", {
		pos = args.pos:copy(),
		vel = vec2(),
		acc = vec2(0, 200),
		radius = 5,
		bounce = 0.05,
		ground_friction = 5,
		air_friction = 0.1,
	})

	local sprite = e:add_component("sprite", "sprite", img)
	sprite.size = vec2(16, 16)
	sprite.framesize = sprite.size:scalar_div(img:getDimensions())
	sprite.pos = body.pos --bind directly to body

	local row = table.pick_random({0, 1}) --randomly pick variation
	sprite.frame:scalar_set(0, row)

	local animation = e:add_component("animation", "animation", sprite)
	animation:add_anim(
		"idle",
		{ {0, row}, },
		10,
		true
	)

	animation:add_anim(
		"walk",
		{ {2, row}, {0, row}, {3, row}, {0, row}, },
		10,
		true
	)

	animation:add_anim(
		"jump",
		{ {4, row} },
		10,
		false
	)

	animation:add_anim(
		"fall",
		{ {5, row} },
		10,
		false
	)

	animation:set_anim("idle")

	require("src.demos.physics.float")(e, body, vec2(0, -10))

	e:add_component("behaviour", "move", {
		jump_timer = timer(0.25),
		angle_timer = timer(0.5),
		last_normal = vec2(0, -1),
		update = function(self, dt)
			local walk_acc = (body.grounded and 500 or 250) * dt
			local max_walk_vel = 60
			local dir = 0
			if keyboard:pressed("left") or keyboard:pressed("a") then
				dir = dir - 1
			end
			if keyboard:pressed("right") or keyboard:pressed("d") then
				dir = dir + 1
			end
			if dir ~= 0 then
				sprite.x_flipped = dir < 0
			end
			--todo: run along normal
			body.vel:scalar_add_inplace(walk_acc * dir, 0)
			body.vel.x = math.sign(body.vel.x) * math.min(math.abs(body.vel.x), max_walk_vel)

			self.jump_timer:update(dt)
			local jump_pressed = keyboard:pressed("up") or keyboard:pressed("w")
			if body.grounded and not jump_pressed then
				self.jump_timer:reset()
			end
			if not self.jump_timer:expired() then
				if jump_pressed then
					local f = self.jump_timer:progress()
					f = math.clamp01(math.lerp(-1, 1, f))
					local jump_force = math.lerp(700, 300, f)
					local jump_dir = vec2(0, -1)
						:lerp_inplace(self.last_normal, 0.25)
						:normalise_inplace()
					body.vel:fused_multiply_add_inplace(jump_dir, jump_force * dt)
				end
			end

			self.angle_timer:update(dt)
			if body.normal:length_squared() > 0 then
				self.angle_timer:reset()
				if body.normal.y <= -0.2 then --stand on slopes
					self.last_normal:vector_set(body.normal)
				end
			elseif self.angle_timer:expired() then
				self.last_normal:scalar_set(0, -1)
			end
			--angle body
			local effective_angle = math.normalise_angle(self.last_normal:angle() + math.tau * 0.25)
			sprite.rot = math.lerp_angle(
				sprite.rot,
				effective_angle,
				0.15
			)

			--animation
			if not body.grounded then
				if jump_pressed and body.vel.y < 0 then
					animation:set_anim("jump")
				else
					animation:set_anim("fall")
				end
			else
				if dir ~= 0 or body.vel:length() > 10 then
					animation:set_anim("walk")
				else
					animation:set_anim("idle")
				end
			end
		end,
	})

	return e
end
