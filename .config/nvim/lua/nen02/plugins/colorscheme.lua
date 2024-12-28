return {
	{
		"navarasu/onedark.nvim",
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			require("onedark").setup({
				style = "dark", -- Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer'
				transparent = true, -- Set this to true for a transparent background
				term_colors = true, -- Set terminal colors
				ending_tildes = false, -- Show end-of-buffer tildes

				-- Custom colors
				colors = {
					bg = "#282c34", -- Background color
					fg = "#abb2bf", -- Foreground color
				},

				-- Customize highlight groups
				highlights = {
					TSFunction = { fg = "#61afef", fmt = "bold" },
					TSKeyword = { fg = "#c678dd" },
					TSString = { fg = "#98c379" },
				},
			})
			-- load the colorscheme here
			vim.cmd([[colorscheme onedark]])
		end,
	},
}
