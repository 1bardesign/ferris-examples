return function(systems, args)
	local e = ferris.entity(systems)

	local img = assets.image.human

	local body = e:add_component("physics", "body", {
		pos = args.pos:copy(),
		vel = vec2(),
		acc = vec2(0, 100),
		radius = 4,
		bounce = 0.05,
		ground_friction = 5,
		air_friction = 0.1,
	})

	local sprite = e:add_component("sprite", "sprite", img)
	sprite.size = vec2(16, 16)
	sprite.framesize = sprite.size:scalar_div(img:getDimensions())
	sprite.pos = body.pos --bind directly to body
	sprite.frame:scalar_set(0, table.pick_random({0, 1}))

	e:add_component("behaviour", "move", {
		jump_timer = timer(0.25),
		angle_timer = timer(0.5),
		last_normal = vec2(0, -1),
		update = function(self, dt)
			local walk_acc = (body.grounded and 400 or 150) * dt
			local max_vel = 100
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
			body.vel.x = math.sign(body.vel.x) * math.min(math.abs(body.vel.x), max_vel)

			self.jump_timer:update(dt)
			local jump_pressed = keyboard:pressed("up") or keyboard:pressed("w")
			if body.grounded and not jump_pressed then
				self.jump_timer:reset()
			end
			if not self.jump_timer:expired() then
				if jump_pressed then
					local f = self.jump_timer:progress()
					f = math.clamp01(math.lerp(-1, 1, f))
					local jump_force = math.lerp(500, 50, f)
					local jump_dir = vec2(0, -1)
						:lerp_inplace(self.last_normal, 0.5)
						:normalise_inplace()
					body.vel:fused_multiply_add_inplace(jump_dir, jump_force * dt)
				end
			end

			self.angle_timer:update(dt)
			if body.normal:length_squared() > 0 then
				self.angle_timer:reset()
				if body.normal.y <= 0 then --stand on edges
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
		end,
	})

	return e
end
