return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local harpoon = require("harpoon")
		harpoon:setup()

		local devicons = require("nvim-web-devicons")
		local pickers = require("telescope.pickers")
		local finders = require("telescope.finders")
		local conf = require("telescope.config").values
		local entry_display = require("telescope.pickers.entry_display")
		local actions = require("telescope.actions")
		local action_state = require("telescope.actions.state")

		-- Function to extract filename and directory
		local function format_path(file_path)
			local filename = file_path:match("([^/]+)$") or file_path
			local dir = file_path:match("(.+)/[^/]+$") or ""
			return filename, dir
		end

		local function toggle_telescope(harpoon_files)
			local displayer = entry_display.create({
				separator = " ",
				items = {
					{}, -- Icon
					{}, -- Filename
					{ remaining = true, highlight = "TelescopeDir" }, -- Directory (darker)
				},
			})

			local function make_display(entry)
				local icon, icon_hl = devicons.get_icon(entry.filename, entry.ext, { default = true })
				return displayer({
					{ icon, icon_hl },
					{ entry.filename },
					{ "  󰉖 " .. entry.dir, "TelescopeDir" },
				})
			end

			local entries = {}
			for _, item in ipairs(harpoon_files.items) do
				local filename, dir = format_path(item.value)
				local ext = filename:match("%.([^%.]+)$") or ""

				table.insert(entries, {
					value = item.value, -- Full file path (Fixes file creation issue)
					ordinal = filename,
					filename = filename,
					dir = dir,
					ext = ext,
					display = make_display,
					path = item.value, -- 🔥 Add this for preview to work
				})
			end

			pickers
				.new({}, {
					prompt_title = "Harpoon",
					finder = finders.new_table({
						results = entries,
						entry_maker = function(entry)
							return {
								value = entry.value, -- Ensure full path is stored
								ordinal = entry.ordinal,
								display = entry.display,
								filename = entry.filename,
								dir = entry.dir,
								ext = entry.ext,
								path = entry.value, -- 🔥 Ensures preview works
							}
						end,
					}),
					previewer = conf.file_previewer({}), -- 🔥 Ensure this is present
					sorter = conf.generic_sorter({}),
					attach_mappings = function(prompt_bufnr, map)
						-- Open selected file properly
						actions.select_default:replace(function()
							local selection = action_state.get_selected_entry()
							actions.close(prompt_bufnr)
							if selection and selection.value then
								vim.cmd("edit " .. vim.fn.fnameescape(selection.value)) -- Fixes root file creation issue
							end
						end)
						return true
					end,
				})
				:find()
		end

		local keymap = vim.keymap

		keymap.set("n", "<leader>ha", function()
			harpoon:list():add()
		end, { noremap = true, silent = true, desc = "Add file to harpoon" })
		keymap.set("n", "<leader>hx", function()
			harpoon:list():remove()
		end, { noremap = true, silent = true, desc = "Remove file from harpoon" })
		keymap.set("n", "<leader>hh", function()
			toggle_telescope(harpoon:list())
		end, { noremap = true, silent = true, desc = "List harpoon marks" })

		for i = 1, 5 do
			keymap.set("n", "<leader>h" .. i, function()
				harpoon:list():select(i)
			end, { noremap = true, silent = true, desc = "Go to harpoon mark " .. i })
		end

		-- Toggle previous & next buffers stored within Harpoon list
		keymap.set("n", "<leader>hp", function()
			harpoon:list():prev()
		end, { noremap = true, silent = true, desc = "Next harpoon mark" })
		keymap.set("n", "<leader>hn", function()
			harpoon:list():next()
		end, { noremap = true, silent = true, desc = "Previous harpoon mark" })
	end,
}
