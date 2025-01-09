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

require("lazy").setup({ { import = "nen02.plugins" }, { import = "nen02.plugins.lsp" } }, {
	checker = {
		enabled = true,
		notify = false,
	},
	change_detection = {
		notify = false,
	},
})
