require("conform").setup({
	-- Define formatters
	formatters = {
		-- biome = {
		-- 	command = "biome",
		-- 	args = { "format", "--stdin-file-path", "$FILENAME" },
		-- 	stdin = true,
		-- },
	},
	formatters_by_ft = {
		-- Lua
		lua = { "stylua" },
		-- JavaScript/TypeScript family
		javascript = { "prettierd" },
		typescript = { "prettierd" },
		javascriptreact = { "prettierd" },
		typescriptreact = { "prettierd" },
		-- For projects using biome (uncomment when needed):
		-- javascript = { "biome" },
		-- typescript = { "biome" },
		-- javascriptreact = { "biome" },
		-- typescriptreact = { "biome" },
		-- Other formats
		css = { "prettierd" },
		html = { "prettierd" },
		json = { "prettierd" },
		yaml = { "prettierd" },
		markdown = { "prettierd" },
	},

	-- Format options - run after ESLint via BufWritePre event ordering
	format_on_save = function(bufnr)
		-- Don't format if the file is huge
		local max_filesize = 100 * 1024 -- 100 KB
		local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(bufnr))
		if ok and stats and stats.size > max_filesize then
			return
		end

		return {
			timeout_ms = 2000,
			lsp_fallback = false, -- Eslint handeled separately, see eslint.lua
			async = false,
		}
	end,
})
