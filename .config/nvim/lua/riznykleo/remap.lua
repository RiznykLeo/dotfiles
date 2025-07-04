vim.g.mapleader = " "

-- NAVIGATION & MOVEMENT
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half page down, center cursor" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half page up, center cursor" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result, center cursor" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result, center cursor" })

vim.keymap.set({ "n", "v" }, "gh", "0", { desc = "Go to beginning of line" })
vim.keymap.set({ "n", "v" }, "gl", "$", { desc = "Go to end of line" })
vim.keymap.set({ "n", "v" }, "ge", "G", { desc = "Go to end of file" })

-- TEXT EDITING & MANIPULATION
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines, keep cursor position" })
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste without losing clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete to void register" })

-- CLIPBOARD OPERATIONS
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Copy to system clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "Copy line to system clipboard" })

-- FILE OPERATIONS
vim.keymap.set("n", "<leader>w", "<cmd>w<CR>", { desc = "Save file" })
vim.keymap.set("n", "<leader>q", "<cmd>q<CR>", { desc = "Quit" })
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true, desc = "Make file executable" })

-- LSP OPERATIONS
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, { desc = "Format buffer" })
vim.keymap.set("n", "<leader>k", "K", { desc = "Show documentation" })
vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, { desc = "Rename symbol" })

-- QUICKFIX NAVIGATION
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz", { desc = "Next quickfix item" })
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz", { desc = "Previous quickfix item" })

-- SEARCH & REPLACE
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Search and replace word under cursor" })

-- DISABLED MAPPINGS
vim.keymap.set("n", "Q", "<nop>", { desc = "Disable Ex mode" })
-- vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
