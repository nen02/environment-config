return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-buffer", -- source for text in buffer
		"hrsh7th/cmp-path", -- source for file system paths
		{
			"L3MON4D3/LuaSnip",
			-- follow latest release.
			version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
			-- install jsregexp (optional!).
			build = "make install_jsregexp",
		},
		"saadparwaiz1/cmp_luasnip", -- for autocompletion
		"rafamadriz/friendly-snippets", -- useful snippets
		"onsails/lspkind.nvim", -- vs-code like pictograms
	},
	config = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")
		local lspkind = require("lspkind")

		local MAX_MENU_WIDTH = 40
		local MAX_ABBR_WIDTH = 40

		-- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
		require("luasnip.loaders.from_vscode").lazy_load()

		cmp.setup({
			completion = {
				completeopt = "menu,menuone,preview,noselect",
			},
			snippet = { -- configure how nvim-cmp interacts with snippet engine
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
				["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
				["<C-e>"] = cmp.mapping.abort(), -- close completion window
				["<CR>"] = cmp.mapping.confirm({ select = false }),
			}),
			-- sources for autocompletion
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip" }, -- snippets
				{ name = "buffer" }, -- text within current buffer
				{ name = "path" }, -- file system paths
			}),
			-- configure lspkind for vs-code like pictograms in completion menu
			formatting = {
				format = function(entry, vim_item)
					-- First, apply lspkind formatting (adds icons)
					vim_item = lspkind.cmp_format({
						mode = "symbol_text", -- show symbol + text
						maxwidth = 50,
						ellipsis_char = "...",
					})(entry, vim_item)

					-- Max out abbr width
					local abbr = vim_item.abbr
					if #abbr > MAX_ABBR_WIDTH then
						vim_item.abbr = abbr:sub(1, MAX_ABBR_WIDTH - 3) .. "..."
					end

					-- Then customize the menu for LSP sources
					if entry.source.name == "nvim_lsp" then
						local detail = entry.completion_item.detail or ""

						-- Remove "Auto import from " prefix
						detail = detail:gsub("^Auto import from ", "")

						-- Remove single or double quotes around the path
						detail = detail:gsub([['(.-)']], "%1") -- for single quotes
						detail = detail:gsub([["(.-)"]], "%1") -- for double quotes

						if #detail > 0 then
							if #detail > MAX_MENU_WIDTH then
								detail = detail:sub(1, MAX_MENU_WIDTH - 3) .. "..."
							end
							vim_item.menu = detail
						end
					end

					return vim_item
				end,
				fields = { "kind", "abbr", "menu" },
				expandable_indicator = false,
			},
		})
	end,
}
