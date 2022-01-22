return function(systems, args)
	local e = ferris.entity(systems)

	local img = assets.image.wheel_bits
	local centre_pos = args.pos

	local struts = 6

	--one-off behaviour for updating the ferris wheel
	local wheel_update = e:add_component("behaviour", "wheel_update", {
		--we populate this later with a group of sprites for each strut of the wheel
		wheel_chunks = {},
		--the current angle
		angle = 0,
		--the turning speed
		speed = 0.2,
		--timer that manages the overall pace of the firework show
		firework_show_timer = timer(40),
		--timer for spacing the fireworks out
		firework_timer = timer(1),
		update = function(self, dt)
			--spin the wheel
			self.angle = math.normalise_angle(self.angle + self.speed * dt)
			for _, chunk in ipairs(self.wheel_chunks) do
				local angle = chunk.angle + self.angle

				--reposition all the various bits of this chunk
				chunk.beam.pos:vset(centre_pos)
				chunk.cog.pos:vset(centre_pos)
				chunk.beam.rot = angle
				chunk.cog.rot = angle
				--seat pivot
				local pivot = vec2(chunk.seat.size.x - 12, 0):rotate_inplace(angle)
				chunk.seat.pos:vset(centre_pos):vector_add_inplace(pivot)
				chunk.seat.rot = 0

				--outer pivot
				local pivot = vec2(chunk.outer.size.x - 20, 0):rotate_inplace(angle + math.tau/struts/2)
				chunk.outer.pos:vset(centre_pos):vector_add_inplace(pivot)
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
					functional.map(self.wheel_chunks, function(v)
						return v.seat.pos:scalar_add(5, 8)
					end),
					--"launcher" tiles on the map
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

	--construct all the various sprites for each strut section
	--the sprites are laid out to make this not a huge chore (but also not trivial)
	for i = 1, struts do
		local angle = math.tau / struts * i

		local beam = e:add_component("sprite", nil, {
			texture = img,
			layout = vec2(1, 4),
			frame = vec2(0, 1),
			pos = centre_pos,
			z = -1,
		})
		beam.offset = vec2(beam.size.x/2 - 2, 0)

		local cog = e:add_component("sprite", nil, {
			texture = img,
			layout = vec2(1, 4),
			frame = vec2(0, 2),
			pos = centre_pos,
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

		--populate the wheel_chunks table with our info
		table.insert(wheel_update.wheel_chunks, {
			angle = angle,
			beam = beam,
			cog = cog,
			seat = seat,
			outer = outer,
		})
	end

	--get everything positioned
	--(we just use the update function so we don't have to double up)
	wheel_update:update(0)

	--convenience function to get the current lowest seat sprite
	local function lowest_seat()
		return functional.find_max(wheel_update.wheel_chunks, function(v)
			return v.seat.pos.y
		end).seat
	end

	--manage some party people, in and out of the ferris wheel
	local people_in = {}
	local people_out = functional.generate(10, function()
		return require("src.demos.sprites.party_person")(systems, {
			pos = vec2(
				math.random_lerp(16, 26),
				16 + 1
			):scalar_mul_inplace(8)
		})
	end)

	--(forward declared so we can use the variable name in our state machine closures)
	local people_management = nil
	--actually set up the behaviour
	people_management = e:add_component("behaviour", "people_management", {
		bindings = {},
		state = state_machine({
			--pull in a character
			get_in = {
				enter = function(self)
					--we wait a little bit each time
					self.timer = timer(1.5)
				end,
				update = function(self, dt)
					self.timer:update(dt)
					if self.timer:expired() then
						--get the lowest seat, and a random person
						local s = lowest_seat()
						local p = table.take_random(people_out)
						--put the person into the "in" set
						table.insert(people_in, p)
						--create a binding table
						--with temporary variables for us to monitor the stuff
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
				--get a shorthand reference to the sprite
				local s = v.person:c("sprite")
				--check if the seat is higher than the centre of the wheel
				local above_middle = v.seat.pos.y < centre_pos.y
				--raise arms when above the middle
				s.frame.x = above_middle
					and 1
					or 0
				--wiggle up and down when above the middle too
				local wiggle_offset = 0
				if above_middle then
					--(we could also accumulate this separately in the binding table)
					local t = love.timer.getTime()
					--calculate a "bouncy" wiggle offset
					wiggle_offset = math.abs(
						math.sin(t * math.tau * 2) * 2
					)
				end
				--anchor to the seat sprite
				s.pos:vector_set(v.seat.pos)
					:scalar_add_inplace(0, 14 - wiggle_offset)
			end
		end,
	})

	return e
end
