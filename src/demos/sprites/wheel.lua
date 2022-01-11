return function(systems, args)
	local self = ferris.entity(systems)

	local img = assets.image.wheel_bits

	local struts = 6

	local wheel_update = self:add_component("behaviour", "wheel_update", {
		wheel_bits = {},
		angle = 0,
		speed = 0.1,
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
		end,
	})

	for i = 1, struts do
		local angle = math.tau / struts * i

		local beam = self:add_component("sprite", nil, img)
		beam.framesize:sset(1):sdivi(1, 4)
		beam.frame:sset(0, 1)
		beam.size:vmuli(beam.framesize)
		beam.pos:vset(args.pos)
		beam.offset:sset(beam.size.x/2 - 2, 0)
		beam.z = -1

		local cog = self:add_component("sprite", nil, img)
		cog.framesize:sset(1):sdivi(1, 4)
		cog.frame:sset(0, 2)
		cog.size:vmuli(cog.framesize)
		cog.pos:vset(args.pos)
		cog.offset:sset(cog.size.x/2 - 3, 0)
		cog.z = 0

		local outer = self:add_component("sprite", nil, img)
		outer.framesize:sset(1):sdivi(1, 4)
		outer.size:vmuli(outer.framesize)
		outer.frame:sset(0, 0)
		outer.z = -2

		local seat = self:add_component("sprite", nil, img)
		seat.framesize:sset(1):sdivi(1, 4)
		seat.size:vmuli(seat.framesize)
		seat.frame:sset(0, 3)
		seat.z = 1
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

	return self
end
