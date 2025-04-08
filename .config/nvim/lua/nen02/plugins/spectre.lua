return {
	"nvim-pack/nvim-spectre",
	dependencies = { "nvim-lua/plenary.nvim" },
	cmd = "Spectre",
	keys = {
		{ "<leader>S", "<cmd>lua require('spectre').toggle()<CR>", desc = "Toggle Spectre" },
		{
			"<leader>sw",
			"<cmd>lua require('spectre').open_visual({select_word=true})<CR>",
			mode = "n",
			desc = "Search current word",
		},
		{
			"<leader>sw",
			"<cmd>lua require('spectre').open_visual()<CR>",
			mode = "v",
			desc = "Search current word",
		},
		{
			"<leader>sf",
			"<cmd>lua require('spectre').open_file_search({select_word=true})<CR>",
			desc = "Search on current file",
		},
	},
	opts = {
		replace_engine = {
			["sed"] = {
				cmd = "sed",
				args = { "-i", "" }, -- Fix: avoid -E issue
				options = {
					["ignore case"] = {
						value = "--ignore-case",
					},
				},
			},
		},
		def = {
			replace = {
				cmd = "sed", -- Use sed with args defined above
			},
		},
	},
}
