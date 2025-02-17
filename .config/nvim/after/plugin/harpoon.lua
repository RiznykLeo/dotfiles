local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

local OsHarpoonKey = "C"

vim.keymap.set("n", "<leader>a", mark.add_file)
vim.keymap.set("n", "<" .. OsHarpoonKey .. "-e>", ui.toggle_quick_menu)

vim.keymap.set("n", "<" .. OsHarpoonKey .. "-h>", function()
	ui.nav_file(1)
end)
vim.keymap.set("n", "<" .. OsHarpoonKey .. "-t>", function()
	ui.nav_file(2)
end)
vim.keymap.set("n", "<" .. OsHarpoonKey .. "-n>", function()
	ui.nav_file(3)
end)
vim.keymap.set("n", "<" .. OsHarpoonKey .. "-s>", function()
	ui.nav_file(4)
end)
