return function(systems, args)
	--create the entity
	local e = ferris.entity(systems)

	--create a sprite for our particle
	local sprite = e:add_component("sprite", "sprite", {
		texture = assets.image.particles,
		pos = args.pos,
		layout = vec2(4, 4),
		frame = vec2(0, args.frame),
		z = args.z or 0,
	})

	--create an animation for our sprite
	local animation = e:add_component("animation", "animation", sprite)
	--set up the animation
	animation:add_anim(
		"puff",
		--we generate some frames, to show off this function
		--using the generate_frames functions from animation can save a lot of typing
		--	and allow moving animations around in your spritesheets more easily too
		--in this case, it's equivalent to { {0, f},  {1, f},  {2, f},  {3, f} }, where f is args.frame 
		animation:generate_frames_ordered_1d(0, args.frame, 4),
		--we want a variable fps so that the particles all animate at different rates
		math.lerp(2, 8, love.math.random()),
		--it shouldn't loop
		false
	)
	--don't forget to set the animation we want to use!
	animation:set_anim("puff")

	--destroy the entity after the animation is finished
	local expire = e:add_component("behaviour", "expire", {
		update = function()
			if animation:done() then
				e:destroy()
			end
		end,
	})

	--this should _really_ be its own system as it's such a common behaviour to want,
	--and inlining the function here is slower than it could be.
	--this is left as-is intentionally though, to show that 
	--	a) it doesn't matter _that_ much, we have many hundreds of these entities without a problem
	--	b) it's pretty easy to fix after-the-fact, if it becomes a problem for your use case
	--think about how you might refactor this component into its own system
	local gravity = e:add_component("behaviour", "transform", {
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
