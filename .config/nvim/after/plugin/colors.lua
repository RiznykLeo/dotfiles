function Colors(color)
	-- Mac
	-- color = color or "rose-pine"
	--Windows
	color = color or "mrkn256"
	vim.cmd.colorscheme(color)
end

function Dark(color)
	Colors(color)

	vim.opt.background = "dark"

	require("lualine").setup({
		options = {
			theme = "codedark",
		},
	})
end

function Light(color)
	Colors(color)
	vim.opt.background = "light"

	require("lualine").setup({
		options = {
			theme = "iceberg_light",
		},
	})
end

Colors()
