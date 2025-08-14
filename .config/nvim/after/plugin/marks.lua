require("marks").setup({
	-- whether to map keybinds or not. default true
	default_mappings = true,
	-- which builtin marks to show. default {}
	builtin_marks = {},
	-- whether movements cycle back to the beginning/end of buffer. default true
	cyclic = true,
	-- whether the shada file is updated after modifying uppercase marks. default false
	force_write_shada = false,
	-- how often (in ms) to redraw signs/recompute mark positions.
	-- higher values will have better performance but may cause visual lag,
	-- while lower values may cause performance penalties. default 150.
	refresh_interval = 250,
	-- sign priorities for each type of mark - builtin marks, uppercase marks, lowercase
	-- marks, and bookmarks.
	-- Set lower priorities so git signs take precedence
	sign_priority = {
		lower = 5, -- lowercase marks (a-z)
		upper = 6, -- uppercase marks (A-Z)
		builtin = 4, -- builtin marks (not shown anyway)
		bookmark = 7, -- bookmarks
	},
	-- disables mark tracking for specific filetypes. default {}
	excluded_filetypes = {},
	-- disables mark tracking for specific buftypes. default {}
	excluded_buftypes = {},
	-- marks.nvim allows you to configure up to 10 bookmark groups, each with its own
	-- sign/virttext. Bookmarks can be used to group together positions and quickly move
	-- across multiple buffers. default sign is '!@#$%^&*()' (from 0 to 9), and
	-- default virt_text is "".
	bookmark_0 = {
		sign = "⚑",
		virt_text = "Important",
		-- explicitly prompt for a virtual line annotation when setting a bookmark from this group.
		-- defaults to false.
		annotate = true,
	},
	mappings = {},
})

vim.api.nvim_set_hl(0, "MarkSignHL", { fg = "#ff0000", bold = true })
vim.api.nvim_set_hl(0, "MarkSignNumHL", { fg = "#ff0000", bold = true })
