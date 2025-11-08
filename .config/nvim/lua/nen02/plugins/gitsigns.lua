return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local gitsigns = require("gitsigns")

		gitsigns.setup({
			current_line_blame = true, -- Enable inline blame for the current line
			current_line_blame_opts = {
				virt_text = true,
				virt_text_pos = "eol", -- Place blame at the end of the line
				delay = 200, -- Delay in milliseconds before showing blame
				ignore_whitespace = false,
			},
			current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
			on_attach = function(bufnr)
				local gs = package.loaded.gitsigns

				local function blame_line()
					gs.blame_line({ full = true })
				end

				local function diff_this()
					gs.diffthis("~")
				end

				local function stage_hunk()
					gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end

				local function reset_hunk()
					gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end

				local function map(mode, l, r, desc)
					vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
				end

				-- Navigation
				map("n", "]c", gs.next_hunk, "Next Hunk")
				map("n", "[c", gs.prev_hunk, "Prev Hunk")

				-- Actions
				map("n", "<leader>gs", gs.stage_hunk, "Stage hunk")
				map("n", "<leader>gr", gs.reset_hunk, "Reset hunk")
				map("v", "<leader>gs", stage_hunk, "Stage hunk")
				map("v", "<leader>gr", reset_hunk, "Reset hunk")
				map("n", "<leader>gS", gs.stage_buffer, "Stage buffer")
				map("n", "<leader>gR", gs.reset_buffer, "Reset buffer")
				map("n", "<leader>gu", gs.undo_stage_hunk, "Undo stage hunk")
				map("n", "<leader>gp", gs.preview_hunk, "Preview hunk")
				map("n", "<leader>gb", blame_line, "Blame line")
				map("n", "<leader>gB", gs.toggle_current_line_blame, "Toggle line blame")
				map("n", "<leader>gd", gs.diffthis, "Diff this")
				map("n", "<leader>gD", diff_this, "Diff this ~")

				-- Text object
				map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "Gitsigns select hunk")
			end,
		})
	end,
}
