vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

-- Example: Map `Ctrl-h` to move left, `Ctrl-l` to move right in Insert Mode
keymap.set("i", "<C-h>", "<Left>", { noremap = true, silent = true })
keymap.set("i", "<C-l>", "<Right>", { noremap = true, silent = true })

keymap.set("n", "<A-S-j>", "yyp", { noremap = true, silent = true, desc = "Duplicate line to next line" })
-- keymap.set("n", "<Esc>K", "yypk", { noremap = true, silent = true, desc = "Duplicate line to previous line" })

keymap.set(
	{ "n", "v" },
	"0",
	"^",
	{ noremap = true, silent = true, desc = "Go to the first non-whitespace character of the line" }
)
keymap.set({ "n", "v" }, "-", "$", { noremap = true, silent = true, desc = "Go to the end of the line" })
keymap.set({ "n", "v" }, "^", "0", { noremap = true, silent = true, desc = "Go to the start of the line" })

-- open lsp definition
-- vim.api.nvim_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>", { noremap = true, silent = true })

-- Harpoon
keymap.set(
	"n",
	"<leader>ha",
	"<cmd>lua require('harpoon.mark').add_file()<CR>",
	{ noremap = true, silent = true, desc = "Add file to harpoon" }
)
keymap.set(
	"n",
	"<leader>hx",
	"<cmd>lua require('harpoon.mark').rm_file()<CR>",
	{ noremap = true, silent = true, desc = "Remove file from harpoon" }
)
keymap.set(
	"n",
	"<leader>hh",
	"<cmd>lua require('telescope').extensions.harpoon.marks()<CR>",
	{ noremap = true, silent = true, desc = "List harpoon marks" }
)
keymap.set(
	"n",
	"<leader>hn",
	"<cmd>lua require('harpoon.ui').nav_next()<CR>",
	{ noremap = true, silent = true, desc = "Next harpoon mark" }
)
keymap.set(
	"n",
	"<leader>hp",
	"<cmd>lua require('harpoon.ui').nav_prev()<CR>",
	{ noremap = true, silent = true, desc = "Previous harpoon mark" }
)
keymap.set(
	"n",
	"<leader>h1",
	"<cmd>lua require('harpoon.ui').nav_file(1)<CR>",
	{ noremap = true, silent = true, desc = "Go to harpoon mark 1" }
)
keymap.set(
	"n",
	"<leader>h2",
	"<cmd>lua require('harpoon.ui').nav_file(2)<CR>",
	{ noremap = true, silent = true, desc = "Go to harpoon mark 2" }
)
keymap.set(
	"n",
	"<leader>h3",
	"<cmd>lua require('harpoon.ui').nav_file(3)<CR>",
	{ noremap = true, silent = true, desc = "Go to harpoon mark 3" }
)
keymap.set(
	"n",
	"<leader>h4",
	"<cmd>lua require('harpoon.ui').nav_file(4)<CR>",
	{ noremap = true, silent = true, desc = "Go to harpoon mark 4" }
)
keymap.set(
	"n",
	"<leader>h5",
	"<cmd>lua require('harpoon.ui').nav_file(5)<CR>",
	{ noremap = true, silent = true, desc = "Go to harpoon mark 5" }
)
keymap.set(
	"n",
	"<leader>h6",
	"<cmd>lua require('harpoon.ui').nav_file(6)<CR>",
	{ noremap = true, silent = true, desc = "Go to harpoon mark 6" }
)
keymap.set(
	"n",
	"<leader>h7",
	"<cmd>lua require('harpoon.ui').nav_file(7)<CR>",
	{ noremap = true, silent = true, desc = "Go to harpoon mark 7" }
)
keymap.set(
	"n",
	"<leader>h8",
	"<cmd>lua require('harpoon.ui').nav_file(8)<CR>",
	{ noremap = true, silent = true, desc = "Go to harpoon mark 8" }
)
keymap.set(
	"n",
	"<leader>h9",
	"<cmd>lua require('harpoon.ui').nav_file(9)<CR>",
	{ noremap = true, silent = true, desc = "Go to harpoon mark 9" }
)

-- Filetype-specific keymaps (these can be done in the ftplugin directory instead if you prefer)
keymap.set("n", "<leader>go", function()
	if vim.bo.filetype == "java" then
		require("jdtls").organize_imports()
	end
end, { desc = "Organize imports" })

keymap.set("n", "<leader>gu", function()
	if vim.bo.filetype == "java" then
		require("jdtls").update_projects_config()
	end
end, { desc = "Update projects config" })

keymap.set("n", "<leader>tc", function()
	if vim.bo.filetype == "java" then
		require("jdtls").test_class()
	end
end, { desc = "Test class" })

keymap.set("n", "<leader>tm", function()
	if vim.bo.filetype == "java" then
		require("jdtls").test_nearest_method()
	end
end, { desc = "Test nearest method" })

-- Debugging
keymap.set("n", "<leader>bb", "<cmd>lua require'dap'.toggle_breakpoint()<cr>")
keymap.set("n", "<leader>bc", "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>")
keymap.set("n", "<leader>bl", "<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<cr>")
keymap.set("n", "<leader>br", "<cmd>lua require'dap'.clear_breakpoints()<cr>")
keymap.set("n", "<leader>ba", "<cmd>Telescope dap list_breakpoints<cr>")
keymap.set("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>")
keymap.set("n", "<leader>dj", "<cmd>lua require'dap'.step_over()<cr>")
keymap.set("n", "<leader>dk", "<cmd>lua require'dap'.step_into()<cr>")
keymap.set("n", "<leader>do", "<cmd>lua require'dap'.step_out()<cr>")
keymap.set("n", "<leader>dd", function()
	require("dap").disconnect()
	require("dapui").close()
end)
keymap.set("n", "<leader>dt", function()
	require("dap").terminate()
	require("dapui").close()
end)
keymap.set("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>")
keymap.set("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>")
keymap.set("n", "<leader>di", function()
	require("dap.ui.widgets").hover()
end)
keymap.set("n", "<leader>d?", function()
	local widgets = require("dap.ui.widgets")
	widgets.centered_float(widgets.scopes)
end)
keymap.set("n", "<leader>df", "<cmd>Telescope dap frames<cr>")
keymap.set("n", "<leader>dh", "<cmd>Telescope dap commands<cr>")
keymap.set("n", "<leader>de", function()
	require("telescope.builtin").diagnostics({ default_text = ":E:" })
end)
