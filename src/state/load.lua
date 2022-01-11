--
local state = {}

--loading content before we get started

--set global graphics stuff on import
lg.setDefaultFilter("nearest", "nearest")
lg.setFont(lg.newFont(12, "mono"))

--
local next_state = "title"

--global, paths replaced with contents
assets = {
	image = {
		--for rendering
		tiles = "tiles.png",
		particles = "particles.png",
	},
	imagedata = {
		--pixel data required
		--anything? level stuff?
	},
	sound = {
		--static audio assets
	},
	music = {
		--streaming audio assets
	},
	map = {
		--tiled lua exports
		title = "title",
	},
}

function state:enter()
	self.k = ferris.kernel()
	
	lg.setBackgroundColor(colour.unpack_argb(0xff000000))

	self.stage = ""
	self.current_target = ""
	self.done = false

	--
	local load_async = async()
	load_async:call(function()
		for _, v in ipairs({
			{"image", function(path)
				return love.graphics.newImage("assets/images/"..path)
			end},
			{"imagedata", function(path)
				return love.image.newImageData("assets/images/"..path)
			end},
			{"sound", function(path)
				return love.audio.newSource("assets/audio/"..path, "static")
			end},
			{"music", function(path)
				return love.audio.newSource("assets/audio/"..path, "streaming")
			end},
			{"map", function(path)
				return require("assets.maps."..path)
			end},
		}) do
			local stage, loader = unpack(v)
			self.stage = ("%s..."):format(stage)
			local collection = assets[stage]
			for name, path in pairs(collection) do
				self.current_target = path
				collection[name] = loader(path)
			end
		end
		self.stage = "done!"
		self.current_target = ""
		async.wait(0.5)
		self.done = true
	end)
	self.k:add_task("update", function(k, dt)
		load_async:update_for_time(5e-3)
	end)
	self.k:add_task("draw", function(k)
		lg.printf(
			("loading %s\n%s")
				:format(
					self.stage,
					self.current_target
				),
			0, screen_canvas:getHeight() / 2.1,
			screen_canvas:getWidth(),
			"center"
		)
	end)
end

function state:update(dt)
	self.k:update(dt)
	if self.done then
		game_state:transition("title")
	end
end

function state:draw()
	self.k:draw()
end

return state
