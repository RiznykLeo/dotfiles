local js_ts_filetypes = {
	"javascript",
	"typescript",
	"javascriptreact",
	"typescriptreact",
	"astro",
}
local formatters_table = {
	lua = { "stylua" },
	css = { "prettierd" },
	graphql = { "prettierd" },
	html = { "prettierd" },
	json = { "prettierd" },
	yaml = { "prettierd" },
	markdown = { "prettierd" },
	python = { "ruff_format" },
}
for _, ft in ipairs(js_ts_filetypes) do
	formatters_table[ft] = { "prettierd" }
end

require("conform").setup({
	formatters_by_ft = formatters_table,
	format_on_save = function(bufnr)
		-- Don't format if the file is huge
		local max_filesize = 4 * 1024 * 1024 -- 4MB
		local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(bufnr))
		if ok and stats and stats.size > max_filesize then
			return
		end
		return {
			timeout_ms = 2000,
			lsp_fallback = false,
			async = false,
		}
	end,
})
