return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
		"folke/todo-comments.nvim",
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		local entry_display = require("telescope.pickers.entry_display")
		local devicons = require("nvim-web-devicons")

		-- Define a function to format the display
		local function make_display(entry)
			local icon, icon_hl = devicons.get_icon(entry.filename, entry.ext, { default = true })

			local displayer = entry_display.create({
				separator = " ",
				items = {
					{}, -- Icon
					{}, -- Filename (auto width)
					{ remaining = true, highlight = "TelescopeDir" }, -- Directory (highlighted)
				},
			})

			return displayer({
				{ icon, icon_hl },
				{ entry.filename }, -- Filename (default color)
				{ "  󰉖 " .. entry.dir, "TelescopeDir" }, -- Directory (darker color)
			})
		end

		-- Custom entry maker
		local function entry_maker(entry)
			local filename = vim.fn.fnamemodify(entry, ":t")
			local dir = vim.fn.fnamemodify(entry, ":h")
			local ext = filename:match("%.([^%.]+)$") or ""

			return {
				value = entry,
				ordinal = entry,
				filename = filename,
				dir = dir,
				ext = ext,
				display = make_display, -- Apply custom formatting
				path = dir .. "/" .. filename,
			}
		end

		telescope.setup({
			defaults = {
				file_ignore_patterns = { "node_modules", "%.class", "%.jar$" },
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous,
						["<C-j>"] = actions.move_selection_next,
						["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
					},
				},
			},
			pickers = {
				find_files = {
					hidden = true,
					follow = true,
					entry_maker = entry_maker, -- Use custom entry maker
				},
			},
		})

		vim.api.nvim_set_hl(0, "TelescopeDir", { fg = "#5C6370" }) -- Dark gray directory

		telescope.load_extension("fzf")
		telescope.load_extension("harpoon")

		-- set keymaps
		local keymap = vim.keymap -- for conciseness

		keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
		keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
		keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
		keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
		keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })

		-- git pickers
		keymap.set(
			"n",
			"<leader>fgc",
			"<cmd>Telescope git_bcommits<cr>",
			{ desc = "Lists commits of the current file" }
		)
		keymap.set("n", "<leader>fgb", "<cmd>Telescope git_branches<cr>", { desc = "Lists git branches" })
		keymap.set("n", "<leader>fgs", "<cmd>Telescope git_branches<cr>", { desc = "Lists git stashes" })
	end,
}
