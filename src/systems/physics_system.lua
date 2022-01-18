--ultra-basic physics system
--has static level geometry and a list of physics bodies which get integrated around

local physics_body = class()

function physics_body:new(args)
	self.pos = args.pos or vec2()
	self.vel = args.vel or vec2()
	self.acc = args.acc or vec2()
	self.mass = args.mass or 1
	self.radius = args.radius or 8
	self.ground_friction = args.ground_friction or 1
	self.air_friction = args.air_friction or 0
	self.grounded = false
	self.was_grounded = false
	self.bounce = args.bounce or 0
end

function physics_body:update(dt)
	self.was_grounded = self.grounded
	self.pos:fused_multiply_add_inplace(self.vel, dt)
	self.vel:fused_multiply_add_inplace(self.acc, dt)
	self.vel:apply_friction_inplace(self.grounded and self.ground_friction or self.air_friction, dt)
end

local physics_system = class()

function physics_system:new()
	ferris.base_system.add_deferred_management(self)
	self.level = {}
end

function physics_system:create_component(args)
	return physics_body(args)
end

function physics_system:add_level_geo(a, b)
	table.insert(self.level, {a, b})
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
				local normal = msv:normalise_inplace()
				intersect.bounce_off(a.vel, normal, a.bounce)
				intersect.bounce_off(b.vel, normal, b.bounce)
			end
		end
	end

	--collide against level
	for _, line in ipairs(self.level) do
		for _, v in ipairs(self.all) do
			if intersect.circle_line_collide(
				v.pos, v.radius,
				line[1], line[2], 1,
				msv
			) then
				v.pos:vector_add_inplace(msv)
				local normal = msv:normalise_inplace()
				intersect.bounce_off(a.vel, normal, a.bounce)
			end
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
		lg.setColor(colour.unpack_argb(0xffff8080))
		for i, v in ipairs(self.all) do
			lg.circle(
				v.pos.x, v.pos.y,
				v.radius
			)
		end
		lg.pop()
	end
end

function physics_system:register(kernel, order)
	ferris.base_system.do_default_register(self, kernel, order)
end

return physics_system
