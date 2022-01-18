return function(systems, args)
	local e = ferris.entity(systems)

	local img = assets.image.dispenser

	local sprite = e:add_component("sprite", "sprite", img)
	sprite.size = vec2(24, 24)
	sprite.framesize = sprite.size:scalar_div(img:getDimensions())
	sprite.pos:set(args.spawn.pos)

	e:add_component("behaviour", "follow_path", {
		path = args.path,
		timer = timer(4),
		update = function(self, dt)
			self.timer:update(dt)
			if self.timer:expired() then
				self.timer:reset()
			end
			local f = math.ease_inout(math.pingpong(self.timer:progress()))
			sprite.pos
				:vset(self.path.a)
				:lerp_inplace(self.path.b, f)
		end,
	})

	return e
end
