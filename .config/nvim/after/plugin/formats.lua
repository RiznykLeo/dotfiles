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
		javascript = { "prettier", "eslint_d" },
		typescript = { "prettier", "eslint_d" },
		javascriptreact = { "prettier", "eslint_d" },
		typescriptreact = { "prettier", "eslint_d" },
		-- For projects using biome (uncomment when needed):
		-- javascript = { "biome" },
		-- typescript = { "biome" },
		-- javascriptreact = { "biome" },
		-- typescriptreact = { "biome" },
		-- Other formats
		css = { "prettier" },
		html = { "prettier" },
		json = { "prettier" },
		yaml = { "prettier" },
		markdown = { "prettier" },
	},
	-- Format options
	format_on_save = {
		timeout_ms = 2000,
		lsp_fallback = true,
		async = false,
		quiet = false,
	},
})
