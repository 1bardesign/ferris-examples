return function(systems, args)
	local img = assets.image.particles

	local e = ferris.entity(systems)
	local sprite = e:add_component("sprite", "sprite", img)

	sprite.pos = args.pos:copy()
	sprite.framesize:sset(1):scalar_div_inplace(4, 4)
	sprite.size:vector_mul_inplace(sprite.framesize)
	sprite.frame:sset(0, args.frame)
	sprite.z = args.z or 0

	local animation = e:add_component("animation", "animation", sprite)
	animation:add_anim(
		"puff",
		animation:generate_frames_ordered_1d(0, args.frame, 4),
		math.lerp(2, 8, love.math.random()),
		false
	)
	animation:set_anim("puff")

	local expire = e:add_component("behaviour", "expire", {
		update = function()
			if animation:done() then
				e:destroy()
			end
		end,
	})

	local gravity = e:add_component("behaviour", "gravity", {
		pos = sprite.pos, --used directly so we don't have to copy
		vel = args.vel,
		acc = vec2(0, args.gravity),
		friction = args.friction or 0,
		update = function(self, dt)
			self.vel:fused_multiply_add_inplace(self.acc, dt)
			self.pos:fused_multiply_add_inplace(self.vel, dt)
			self.vel:apply_friction_inplace(self.friction, dt)
		end,
	})
	return p
end
