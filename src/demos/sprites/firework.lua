return function(systems, args)
	local e = ferris.entity(systems)

	local img = assets.image.particles

	local speed_mul = 20
	local gravity = 100

	local ring_rad = math.random_lerp(8, 12)
	local ring_res = 32
	local struts = 6
	local strut_res = 5

	local angle_offset = love.math.random()

	local boom_offsets = table.append(
		--ring
		functional.generate(ring_res, function(i)
			local f = (i / ring_res) + angle_offset
			return vec2(ring_rad, 0):rotate_inplace(f * math.tau)
		end),
		--beams
		table.collapse(
			functional.generate(struts, function(i)
				local angle = (i / struts + angle_offset) * math.tau
				local dir = vec2(1, 0):rotate_inplace(angle)
				return functional.generate(strut_res, function(i)
					local f = (i / strut_res)
					local d = ring_rad * f
					return dir:scalar_mul(d)
				end)
			end)
		)
	)

	local firework_update = e:add_component("behaviour", "firework_update", {
		pos = args.pos:copy(),
		vel = args.vel:copy():scalar_mul_inplace(speed_mul),
		acc = vec2(0, gravity),
		friction = 2,
		emit = true,
		emit_now = true,
		emit_timer = timer(
			0.05,
			nil,
			function()
				e:c("firework_update").emit_now = true
			end
		),
		boom_timer = timer(
			args.time,
			nil,
			function()
				e:c("firework_update"):boom(boom_offsets)
				e:destroy()
			end
		),
		update = function(self, dt)
			self.pos:fused_multiply_add_inplace(self.vel, dt)
			self.vel:fused_multiply_add_inplace(self.acc, dt)
			self.vel:apply_friction_inplace(self.friction, dt)

			self.emit_timer:update(dt)
			self.boom_timer:update(dt)

			if self.emit then
				if self.emit_now then
					self.emit_now = false
					self.emit_timer:reset()
					self:add(vec2(1, 0):rotate_inplace(love.math.random() * math.tau))
				end
			end
		end,
		boom = function(self, offsets)
			for i, v in ipairs(offsets) do
				self:add(v)
			end
		end,
		add = function(self, vel, time)
			local p = ferris.entity(systems)
			local sprite = p:add_component("sprite", "sprite", img)

			sprite.pos = self.pos:copy()
			sprite.framesize:sset(1):scalar_div_inplace(4, 4)
			sprite.size:vector_mul_inplace(sprite.framesize)
			sprite.frame:sset(0, 0)
			sprite.z = 10

			local animation = p:add_component("animation", "animation", sprite)
			animation:add_anim(
				"puff",
				animation:generate_frames_ordered_1d(0, 0, 4),
				math.lerp(2, 8, love.math.random()),
				false
			)
			animation:set_anim("puff")

			local expire = p:add_component("behaviour", "expire", {
				update = function()
					if animation:done() then
						p:destroy()
					end
				end,
			})

			local gravity = p:add_component("behaviour", "gravity", {
				pos = sprite.pos, --used directly so we don't have to copy
				vel = vel:copy()
					:scalar_mul_inplace(speed_mul)
					:fused_multiply_add_inplace(self.vel, 0.5),
				acc = vec2(0, gravity),
				friction = 5,
				update = function(self, dt)
					self.pos:fused_multiply_add_inplace(self.vel, dt)
					self.vel:fused_multiply_add_inplace(self.acc, dt)
					self.vel:apply_friction_inplace(self.friction, dt)
				end,
			})
		end,
	})

	--starting scatter
	local start_scatter = 8
	local start_offsets = functional.generate(start_scatter, function(i)
		return vec2(math.random_lerp(0.5, 2), 0)
			:rotate_inplace(love.math.random() * math.tau)
	end)
	firework_update:boom(start_offsets)

	return e
end
