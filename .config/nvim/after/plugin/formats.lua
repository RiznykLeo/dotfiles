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
	-- Format options
	format_on_save = {
		timeout_ms = 2000,
		lsp_fallback = true,
		async = false,
		quiet = false,
	},
})
