return function(systems, args)
	local e = ferris.entity(systems)

	local img = assets.image.wheel_bits

	local struts = 6

	local wheel_update = e:add_component("behaviour", "wheel_update", {
		wheel_bits = {},
		angle = 0,
		speed = 0.2,
		firework_show_timer = timer(40),
		firework_timer = timer(1),
		update = function(self, dt)
			self.angle = math.normalise_angle(self.angle + self.speed * dt)
			for _, chunk in ipairs(self.wheel_bits) do
				local angle = chunk.angle + self.angle

				chunk.beam.pos:vset(args.pos)
				chunk.cog.pos:vset(args.pos)
				chunk.beam.rot = angle
				chunk.cog.rot = angle
				--seat pivot
				local pivot = vec2(chunk.seat.size.x - 12, 0):rotate_inplace(angle)
				chunk.seat.pos:vset(args.pos):vector_add_inplace(pivot)
				chunk.seat.rot = 0

				--outer pivot
				local pivot = vec2(chunk.outer.size.x - 20, 0):rotate_inplace(angle + math.tau/struts/2)
				chunk.outer.pos:vset(args.pos):vector_add_inplace(pivot)
				chunk.outer.rot = angle + (math.tau / struts) * 2
			end

			--whole show timing
			self.firework_show_timer:update(dt)
			if self.firework_show_timer:expired() then
				self.firework_show_timer:reset()
			end

			--individual launch timing
			self.firework_timer:update(dt)
			if self.firework_timer:expired() or keyboard:just_pressed("space") then
				self.firework_timer:reset(
					math.lerp(
						2, 0.1,
						math.clamp01(math.sin((self.firework_show_timer:progress() + 0.5) * math.tau))
					)
					+ math.random_lerp(0.0, 0.2)
				)
				local possible_pos = table.append(
					--seat positions
					functional.map(self.wheel_bits, function(v)
						return v.seat.pos:scalar_add(5, 8)
					end),
					--tiles
					{
						vec2(7, 14)
							:scalar_add_inplace(0.5, 0)
							:scalar_mul_inplace(8),
						vec2(10, 12)
							:scalar_add_inplace(0.5, 0)
							:scalar_mul_inplace(8),
						vec2(16, 17)
							:scalar_add_inplace(0.5, 0)
							:scalar_mul_inplace(8),
						vec2(33, 12)
							:scalar_add_inplace(0.5, 0)
							:scalar_mul_inplace(8),
					}
				)
				local pos = table.pick_random(possible_pos)
				require("src.demos.sprites.firework")(systems, {
					pos = pos,
					vel = vec2(0, math.random_lerp(-8, -12)):rotate_inplace(
						--(biased outwards angles)
						math.sqrt(love.math.random())
						* math.random_sign()
						--(spread half)
						/ 2
						--range
						* 0.2 * math.tau
					),
					time = math.lerp(1.2, 2.0, love.math.random())
				})
			end
		end,
	})

	for i = 1, struts do
		local angle = math.tau / struts * i

		local beam = e:add_component("sprite", nil, {
			texture = img,
			layout = vec2(1, 4),
			frame = vec2(0, 1),
			pos = args.pos,
			z = -1,
		})
		beam.offset = vec2(beam.size.x/2 - 2, 0)

		local cog = e:add_component("sprite", nil, {
			texture = img,
			layout = vec2(1, 4),
			frame = vec2(0, 2),
			pos = args.pos,
			z = 0,
		})
		cog.offset:sset(cog.size.x/2 - 3, 0)

		local outer = e:add_component("sprite", nil, {
			texture = img,
			layout = vec2(1, 4),
			frame =  vec2(0, 0),
			z = -2,
		})

		local seat = e:add_component("sprite", nil, {
			texture = img,
			layout = vec2(1, 4),
			frame = vec2(0, 3),
			z = 1,
		})
		seat.offset:sset(0, seat.size.y/2 - 1)

		table.insert(wheel_update.wheel_bits, {
			angle = angle,
			beam = beam,
			cog = cog,
			seat = seat,
			outer = outer,
		})
	end

	--get everything positioned
	wheel_update:update(0)

	--manage some party people in and out
	local people_in = {}
	local people_out = functional.generate(10, function()
		return require("src.demos.sprites.party_person")(systems, {
			pos = vec2(
				math.random_lerp(16, 26),
				16 + 1
			):scalar_mul_inplace(8)
		})
	end)
	local function lowest_seat()
		return functional.find_max(wheel_update.wheel_bits, function(v)
			return v.seat.pos.y
		end).seat
	end

	local people_management = nil --so we can bind in state machine closures
	people_management = e:add_component("behaviour", "people_management", {
		bindings = {},
		state = state_machine({
			get_in = {
				enter = function(self)
					self.timer = timer(1.5)
				end,
				update = function(self, dt)
					self.timer:update(dt)
					if self.timer:expired() then
						local s = lowest_seat()
						local p = table.take_random(people_out)
						table.insert(people_in, p)
						local binding = {
							person = p,
							old_pos = p:c("sprite").pos:copy(),
							seat = s,
						}
						table.insert(people_management.bindings, binding)
						return "wait_next"
					end
				end,
			},
			wait_next = {
				enter = function(self)
					self.prev_lowest = lowest_seat()
				end,
				update = function(self)
					if lowest_seat() ~= self.prev_lowest then
						return "get_out"
					end
				end,
			},
			get_out = {
				update = function(self)
					local binding = functional.find_match(people_management.bindings, function(v)
						return v.seat == lowest_seat()
					end)
					if binding then
						table.remove_value(people_in, binding.person)
						table.insert(people_out, binding.person)

						person_sprite = binding.person:c("sprite")
						person_sprite.pos:vset(binding.old_pos)
						person_sprite.x_flipped = love.math.random() < 0.5

						table.remove_value(people_management.bindings, binding)
					end
					return "get_in"
				end,
			},
		}, "get_in"),
		update = function(self, dt)
			self.state:update(dt)
			for i, v in ipairs(self.bindings) do
				v.person:c("sprite").pos:vset(v.seat.pos):scalar_add_inplace(0, 14)
			end
		end,
	})

	return e
end
