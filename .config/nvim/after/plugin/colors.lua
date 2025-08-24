function Colors(color)
	-- Rust getting different theme
	if not color then
		if vim.fn.filereadable("Cargo.toml") == 1 then
			color = "vividchalk"
			vim.opt.background = "dark"
		else
			color = color or "rose-pine"
		end
	end

	vim.cmd.colorscheme(color)

	local lualine_theme = vim.o.background == "dark" and "codedark" or "iceberg_light"
	require("lualine").setup({
		options = {
			theme = lualine_theme,
		},
	})
end

function Dark(color)
	vim.opt.background = "dark"
	Colors(color)
end

function Light(color)
	vim.opt.background = "light"
	Colors(color)
end

Colors()
