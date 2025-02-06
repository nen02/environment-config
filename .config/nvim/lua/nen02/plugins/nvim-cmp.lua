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
		local keymap = vim.keymap
		local cmp = require("cmp")

		local luasnip = require("luasnip")
		local s = luasnip.snippet
		local t = luasnip.text_node
		local i = luasnip.insert_node

		local lspkind = require("lspkind")

		-- snippets for jsoc
		luasnip.add_snippets("javascript", {
			s("jsdoc-method", {
				t({ "/**", " * " }),
				i(1, "Description"),
				t({ "", " * @param {" }),
				i(2, "paramType"),
				t({ "}" }),
				t({ " " }),
				i(3, "paramName"),
				t({ "", " * @returns {" }),
				i(4, "returnType"),
				t({ "}" }),
				t({ "", " */" }),
			}),
			s("jsdoc-type", {
				t({ "/**" }),
				t({ "", " * @type {" }),
				i(1, "type"),
				t({ "}" }),
				t({ "", " */" }),
			}),
			s("jsdoc-typedef", {
				t({ "/**" }),
				t({ "", " * @typedef {" }),
				i(1, "type"),
				t({ "} " }),
				i(2, "name"),
				t({ "", " */" }),
			}),
		})

		-- use tab to go to next node when using snippets
		keymap.set({ "i", "s" }, "<Tab>", function()
			if luasnip.expand_or_jumpable() then
				luasnip.jump(1)
			end
		end, { silent = true })

		keymap.set({ "i", "s" }, "<S-Tab>", function()
			if luasnip.jumpable(-1) then
				luasnip.jump(-1)
			end
		end, { silent = true })

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
				format = lspkind.cmp_format({
					maxwidth = 50,
					ellipsis_char = "...",
				}),
			},
		})
	end,
}
