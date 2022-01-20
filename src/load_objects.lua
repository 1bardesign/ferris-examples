--load objects from a tiled level
--ignores transformation of the layers, so, don't do that
local function load_objects(map, layer_name)
	local layer = functional.find_match(map.layers, function(v)
		return v.name == layer_name
	end)
	assert:equal(layer.type, "objectgroup", "object layer type")
	--todo: support offset, rotation, etc
	assert:equal(layer.offsetx, 0, "object layer offset")
	assert:equal(layer.offsety, 0, "object layer offset")
	return functional.stitch(layer.objects, function(v)
		assert:equal(v.rotation, 0, "not object rotation")
		local pos = vec2(v.x, v.y)
		if v.shape == "polyline" then
			return functional.chain(v.polyline, function(a, b)
				return {
					shape = "line",
					type = v.type,
					name = v.name,
					a = pos:scalar_add(a.x, a.y),
					b = pos:scalar_add(b.x, b.y),
				}
			end)
		end

		if v.shape == "polygon" then
			return functional.cycle(v.polygon, function(a, b)
				return {
					shape = "line",
					type = v.type,
					name = v.name,
					a = pos:scalar_add(a.x, a.y),
					b = pos:scalar_add(b.x, b.y),
				}
			end)
		end

		if v.shape == "point" then
			return {
				{
					shape = "point",
					type = v.type,
					name = v.name,
					pos = pos,
				}
			}
		end

		if v.shape == "rectangle" then
			local halfsize = vec2(v.width, v.height):scalar_mul_inplace(0.5)
			return {
				{
					shape = "aabb",
					type = v.type,
					name = v.name,
					pos = pos:vector_add(halfsize),
					halfsize = halfsize,
				}
			}
		end

		error("unsupported object type")

	end)
end

return load_objects
