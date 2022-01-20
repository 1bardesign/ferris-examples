return function(e, body, float_acceleration)
	e:add_component("behaviour", "float", {
		in_water = nil,
		old_acc = body.acc:copy(),
		float_acceleration = float_acceleration,
		splash_limit = timer(0.1),
		update = function(self, dt)
			self.splash_limit:update(dt)
			if self.in_water ~= body.zones.water then
				self.in_water = body.zones.water
				if self.in_water then
					self.old_acc:vector_set(body.acc)
					body.acc:vector_set(self.float_acceleration)
					--lose velocity when entering water
					body.vel:scalar_mul_inplace(0.2)
				else
					body.acc:vector_set(self.old_acc)
				end
				if self.splash_limit:expired() then
					--spawn some splash particles based on entry/exit vel
					local particles_amount = math.floor(math.lerp(-1, 10, math.clamp01(body.vel:length() / 50)))
					for i = 1, particles_amount do
						require("src.shared_entities.particle")(e.systems, {
							frame = love.math.random(2, 3),
							pos = body.pos:add(
								vec2(0, body.radius)
									:scalar_mul_inplace(love.math.random())
									:rotate_inplace(math.tau * love.math.random())
							),
							vel = body.vel:copy()
								:scalar_mul_inplace(-0.2) --against the splash
								:vector_add_inplace(
									vec2(0, 10)
										:scalar_mul_inplace(love.math.random())
										:rotate_inplace(math.tau * love.math.random())
								),
							gravity = 10,
							friction = 2,
							z = 10,
						})
					end
					self.splash_limit:reset()
				end
			end
		end,
	})
end
