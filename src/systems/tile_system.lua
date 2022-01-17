--ultra-basic tilemap which just renders the first layer of a lua-exported tiled map
--with a given image and tile size (ie doesn't read out much meta data, just the tile data + dimensions)

local tile_system = class()

function tile_system:new(args)
	local map = args.map
	local image = map.image
	local tilesize = map.tilesize
	local layer = map.layers[1]
	if args.layer then
		layer = functional.find_match(map.layers, function(v)
			return v.name == args.layer
		end)
		assert:some(layer, "layer for tile system")
	end
	self.size = vec2(layer.width, layer.height)
	self.tilesize = tilesize
	self.image = image
	self.image_layout = vec2(self.image:getDimensions())
		:vector_div_inplace(tilesize)
		:floor_inplace()
	self.quad = lg.newQuad(
		0, 0,
		tilesize.x, tilesize.y,
		self.image:getDimensions()
	)
	self.tiles = layer.data
	self.pos = args.pos or vec2()
end

function tile_system:update(dt)

end

function tile_system:draw()
	--opt: cull drawing to a passed in camera
	for y = 1, self.size.y do
		for x = 1, self.size.x do
			local tx = (x - 1) * self.tilesize.x
			local ty = (y - 1) * self.tilesize.y
			local idx = ((x - 1) + (y - 1) * self.size.x) + 1
			local t = self.tiles[idx] - 1
			if t >= 0 then
				self.quad:setViewport(
					math.floor(t % self.image_layout.x) * self.tilesize.x,
					math.floor(t / self.image_layout.x) * self.tilesize.y,
					self.tilesize.x,
					self.tilesize.y
				)
				lg.draw(self.image, self.quad, tx, ty)
			end
		end
	end
end

function tile_system:register(kernel, order)
	ferris.base_system.do_default_register(self, kernel, order)
end

return tile_system
