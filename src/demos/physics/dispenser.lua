return function(systems, args)
	local e = ferris.entity(systems)

	local img = assets.image.dispenser

	local body = e:add_component("physics", "body", {
		pos = args.spawn.pos:copy(),
		solid = false,
	})

	local sprite = e:add_component("sprite", "sprite", img)
	sprite.size = vec2(24, 24)
	sprite.framesize = sprite.size:scalar_div(img:getDimensions())
	sprite.pos = body.pos --bind directly to body
	sprite.z = 1

	e:add_component("behaviour", "dispense ball", {
		timer = timer(1.13),
		update = function(self, dt)
			self.timer:update(dt)
			if self.timer:expired() then
				self.timer:reset()
				local b = require("src.demos.physics.ball")(systems, {
					pos = body.pos:scalar_add(0, 10),
					vel = vec2(math.random_lerp(-1, 1) * 10, 80),
				})
				local particles_amount = 10
				for i = 1, particles_amount do
					require("src.shared_entities.particle")(e.systems, {
						frame = love.math.random(0, 1),
						pos = b:c("body").pos,
						vel = b:c("body").vel
							:scalar_mul(math.random_lerp(0.1, 0.8))
							:vector_add(
								vec2(1, 0)
									:scalar_mul_inplace(love.math.random())
									:rotate_inplace(math.tau * love.math.random())
									:scalar_mul_inplace(50, 10)
							),
						gravity = 10,
						friction = 2,
						z = 10,
					})
				end
			end
		end,
	})

	e:add_component("behaviour", "follow path", {
		path = {
			args.path.a:round(),
			args.path.b:round(),
		},
		timer = timer(6),
		update = function(self, dt)
			self.timer:update(dt)
			if self.timer:expired() then
				self.timer:reset()
			end
			local f = math.ease_inout(math.pingpong(self.timer:progress()))
			sprite.pos
				:vset(self.path[1])
				:lerp_inplace(self.path[2], f)
		end,
	})

	return e
end
