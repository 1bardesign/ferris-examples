--
local state = {}

--title screen for the demo

local major_col = 0xffffffff
local minor_col = 0xffa0a0a0

function state:enter()
	--just the tilemap for now
	self.k = ferris.kernel()
		:add_system("tiles", require("src.systems.tile_system"){
			map = assets.map.title,
			image = assets.image.tiles,
			tilesize = vec2(8, 8),
		})
	
	--set up some graphics stuff
	self.title_font = lg.newFont(48, "mono")
	lg.setBackgroundColor(colour.unpack_argb(0xffbed6fd))

	--note: no nice UI stuff yet :)
	--	this should be simple enough to understand, though
	self.menu = {
		{"info", [[
			This is a collection of examples for Ferris; a game making toolkit built on top of löve.

			Be sure to explore the code afterwards! It is written to be easy to understand, and is freely licensed (zlib) so you can use it in your own projects.

			Use this menu with the arrow keys and space/enter/z
		]], function()
			--
		end},
		{"demos", [[
			These are the feature demos, self-contained scenes to help you understand how to use ferris.

			You can view the source code under src/demos
		]], function()
			game_state:transition("demos")
		end},
		{"game", [[
			This will lead to the example game, when it's done!

			The game will be a more involved example integrating a lot of the concepts from the demos, with some new stuff as well.
		]], function()
			-- game_state:transition("game")
		end},
		{"source code", [[
			The code for these examples, and for Ferris itself, is currently hosted on github, and is freely available under the zlib license.

			Select this option to view the example repository.
		]], function()
			love.system.openURL("https://github.com/1bardesign/ferris-examples/")
		end},
		{"art", [[
			The art used is adapted from CC0 art from the magnificent "surt"; the adaptations are likewise licensed CC0.

			Select this option to view the OpenGameArt listing.
		]], function()
			love.system.openURL("https://opengameart.org/content/nesmup")
		end},
		{"quit", [[
			Bye!
		]], function()
			love.event.quit()
		end},
	}
	self.selected = 1

	--interaction with menu
	self.k:add_task("update", function(k, dt)
		if keyboard:just_pressed("escape") then
			love.event.quit()
		end

		if keyboard:just_pressed("up") then
			self.selected = self.selected - 1
		end
		if keyboard:just_pressed("down") then
			self.selected = self.selected + 1
		end
		self.selected = math.clamp(self.selected, 1, #self.menu)

		if
			keyboard:just_pressed("space")
			or keyboard:just_pressed("return")
			or keyboard:just_pressed("z")
		then
			self.menu[self.selected][3]()
		end
	end)

	--drawing the menu
	self.k:add_task("draw_ui", function(k)
		lg.push("all")

		local para_w = 360
		local menu_w = 200

		lg.setColor(colour.unpack_argb(major_col))

		lg.translate(0, 26)
		lg.push("all")
		lg.setFont(self.title_font)
		lg.printf(
			([[
				ferris-examples
			]]):dedent(),
			0, 0,
			ui_canvas:getWidth(),
			"center"
		)
		lg.pop()

		lg.translate(0, 68)
		for i, v in ipairs(self.menu) do
			local s = v[1]
			lg.setColor(colour.unpack_argb(minor_col))
			if i == self.selected then
				lg.setColor(colour.unpack_argb(major_col))
				s = "> "..s
			end
			lg.printf(
				s,
				ui_canvas:getWidth()/2 - menu_w/2, 0,
				menu_w,
				"left"
			)
			lg.translate(0, 16)
		end
		lg.translate(0, 20)
		--
		lg.setColor(colour.unpack_argb(major_col))
		lg.printf(
			(self.menu[self.selected][2]):dedent(),
			ui_canvas:getWidth()/2 - para_w/2, 0,
			para_w,
			"left"
		)

		lg.pop()
	end)
end

function state:update(dt)
	self.k:update(dt)
	if self.transition then
		game_state:transition(self.transition)
	end
end

function state:draw()
	self.k:draw()
end

function state:draw_ui()
	self.k:run_task("draw_ui")
end

return state
