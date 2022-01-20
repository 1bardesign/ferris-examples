--ultra-basic physics system
--has static level geometry and a list of physics bodies which get integrated around

local physics_body = class()

function physics_body:new(args)
	self.pos = args.pos or vec2()
	self.vel = args.vel or vec2()
	self.acc = args.acc or vec2()
	self.mass = args.mass or 1
	self.radius = args.radius or 8
	self.normal = vec2(0, 0)
	self.ground_friction = args.ground_friction or 1
	self.air_friction = args.air_friction or 0
	self.grounded = false
	self.was_grounded = false
	self.bounce = args.bounce or 0
	self.collisions = {}
	self.zones = {}

	self.solid = args.solid
	if self.solid == nil then
		self.solid = true
	end
	self.collide_map = args.collide_map
	if self.collide_map == nil then
		self.collide_map = true
	end
end

function physics_body:update(dt)
	self.vel:fused_multiply_add_inplace(self.acc, dt)
	self.pos:fused_multiply_add_inplace(self.vel, dt)
	self.vel:apply_friction_inplace(self.grounded and self.ground_friction or self.air_friction, dt)
	self.was_grounded = self.grounded
	self.normal:scalar_set(0, 0)
	table.clear(self.collisions)
	table.clear(self.zones)
end

local physics_system = class()

--can make this less than one to stay overlapping between frames rather than strobing even if not "pushing together"
local resolve_amount = 1

function physics_system:new()
	ferris.base_system.add_deferred_management(self)
	self.level = {}
	self.zones = {}
end

function physics_system:create_component(args)
	return physics_body(args)
end

function physics_system:add_level_geo(a, b)
	table.insert(self.level, {a, b})
end
function physics_system:add_zone(pos, halfsize, type)
	table.insert(self.zones, {
		pos = pos,
		halfsize = halfsize,
		type = type,
	})
end

function physics_system:update(dt)
	--integrate
	for _, v in ipairs(self.all) do
		v:update(dt)
	end

	--collide bodies
	local msv = vec2:pooled()
	for i = 1, #self.all do
		for j = i+1, #self.all do
			local a = self.all[i]
			local b = self.all[j]
			if a.solid and b.solid then
				local balance = intersect.balance_from_mass(a.mass, b.mass)
				if balance and intersect.circle_circle_collide(
					a.pos, a.radius,
					b.pos, b.radius,
					msv
				) then
					intersect.resolve_msv(
						a.pos,
						b.pos,
						msv,
						balance
					)
					--note, can only collide in one direction due to how the loops are formulated
					local normal = msv:normalise()
					table.insert(a.collisions, {
						other = b,
						normal = normal,
					})
					table.insert(b.collisions, {
						other = a,
						normal = normal:inverse(),
					})
				end
			end
		end
	end

	--collide against level
	for _, v in ipairs(self.all) do
		if v.collide_map then
			for _, line in ipairs(self.level) do
				if intersect.circle_line_collide(
					v.pos, v.radius,
					line[1], line[2],
					0.5, --line radius
					msv
				) then
					v.pos:fused_multiply_add_inplace(msv, resolve_amount)
					table.insert(v.collisions, {
						other = "map",
						normal = msv:normalise(),
					})
				end
			end
		end
	end

	--check zones
	for _, v in ipairs(self.all) do
		if v.collide_map then
			for _, zone in ipairs(self.zones) do
				if intersect.point_aabb_overlap(
					v.pos, --note: just point, so we only enter when the centre is inside
					zone.pos, zone.halfsize
				) then
					v.zones[zone.type] = true
				end
			end
		end
	end

	--calc grounded and perform bounce and momentum transfer
	local oldvel = vec2()
	local delta = vec2()
	local target_normal = vec2(0, -1)
	for _, v in ipairs(self.all) do
		v.grounded = false
		for _, col in ipairs(v.collisions) do
			--cache old velocity
			oldvel:vector_set(v.vel)
			--do bounce
			intersect.bounce_off(v.vel, col.normal, v.bounce)

			--transfer change in momentum
			if col.other ~= "map" then
				delta:vector_set(v.vel)
					:vector_sub_inplace(oldvel)
					:scalar_mul_inplace(v.mass)
					:scalar_div_inplace(col.other.mass)
					:scalar_mul_inplace(col.other.bounce)

				col.other.vel:vector_sub_inplace(delta)
			end

			if col.normal.y < -0.2 then
				v.grounded = true
			end
		end
		local groundlike_normal = functional.find_min(v.collisions, function(col)
			return col.normal:angle_difference(target_normal)
		end)
		if groundlike_normal then
			v.normal:vector_set(groundlike_normal.normal)
		else
			v.normal:scalar_set(0)
		end
	end

	msv:release()
end

function physics_system:draw()
	if keyboard:pressed("`") then
		lg.push("all")
		lg.setColor(colour.unpack_argb(0xff80ff80))
		for i, v in ipairs(self.level) do
			lg.line(
				v[1].x, v[1].y,
				v[2].x, v[2].y
			)
		end
		lg.setColor(colour.unpack_argb(0xff80ffff))
		for i, v in ipairs(self.zones) do
			lg.rectangle(
				"line",
				v.pos.x - v.halfsize.x, v.pos.y - v.halfsize.y,
				v.halfsize.x * 2, v.halfsize.y * 2
			)
		end
		for i, v in ipairs(self.all) do
			lg.setColor(colour.unpack_argb(v.solid and 0xffff8080 or 0x80ff8080))
			lg.circle(
				"line",
				v.pos.x, v.pos.y,
				v.radius
			)
			for _, col in ipairs(v.collisions) do
				lg.setColor(colour.unpack_argb(0xff8080ff))
				local col_len = v.radius
				lg.line(
					v.pos.x, v.pos.y,
					v.pos.x + col.normal.x * col_len, v.pos.y + col.normal.y * col_len
				)
			end
		end
		lg.pop()
	end
end

function physics_system:register(kernel, order)
	ferris.base_system.do_default_register(self, kernel, order)
end

return physics_system
