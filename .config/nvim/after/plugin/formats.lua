local function has_biome_config()
	local biome_configs = {
		"biome.json",
		"biome.jsonc",
	}

	local current_dir = vim.fn.getcwd()
	for _, config in ipairs(biome_configs) do
		if vim.fn.filereadable(current_dir .. "/" .. config) == 1 then
			return true
		end
	end
	return false
end

local js_ts_filetypes = {
	"javascript",
	"typescript",
	"javascriptreact",
	"typescriptreact",
}

local formatters_table = {
	lua = { "stylua" },

	css = { "prettierd" },
	html = { "prettierd" },
	json = { "prettierd" },
	yaml = { "prettierd" },
	markdown = { "prettierd" },
}

for _, ft in ipairs(js_ts_filetypes) do
	if has_biome_config() then
		formatters_table[ft] = { "biome" }
	else
		formatters_table[ft] = { "prettierd" }
	end
end

require("conform").setup({
	formatters = {
		biome = {
			command = "biome",
			args = { "format", "--stdin-file-path", "$FILENAME" },
			stdin = true,
		},
	},
	formatters_by_ft = formatters_table,

	format_on_save = function(bufnr)
		-- Don't format if the file is huge
		local max_filesize = 100 * 1024 -- 100 KB
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

