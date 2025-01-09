local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

vim.o.foldmethod = "expr" -- Use expression-based folding
vim.o.foldexpr = "nvim_treesitter#foldexpr()" -- Use Tree-sitter's folding expression
vim.o.foldenable = true -- Enable folding by default
vim.o.foldlevel = 99 -- Start with all folds open

vim.opt.foldtext = "v:lua.CustomFoldText()"
vim.opt.fillchars = "fold: "
-- vim.api.nvim_set_hl(0, "Folded", { bg = "#2e3440", fg = "#88c0d0" })
function _G.CustomFoldText()
	local line = vim.fn.getline(vim.v.foldstart) -- Get the first line of the fold
	local lines = vim.v.foldend - vim.v.foldstart + 1 -- Number of lines in the fold
	local is_closed = vim.fn.foldclosed(vim.v.foldstart) ~= -1 -- Check if the fold is closed
	local arrow = is_closed and "▶" or "▼" -- Choose the arrow based on fold state
	return arrow .. " " .. line .. "  (" .. lines .. " lines)"
end

require("lazy").setup({ { import = "nen02.plugins" }, { import = "nen02.plugins.lsp" } }, {
	checker = {
		enabled = true,
		notify = false,
	},
	change_detection = {
		notify = false,
	},
})
