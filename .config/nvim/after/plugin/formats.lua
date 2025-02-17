require("conform").setup({
	-- Define formatters
	formatters = {
		deno_fmt = {
			command = "deno",
			args = { "fmt", "-" },
			-- Deno fmt supports multiple file types
			stdin = true,
		},
	},

	formatters_by_ft = {
		-- Lua
		lua = { "stylua" },

		-- JavaScript/TypeScript family
		javascript = { "deno_fmt", "prettier" },
		typescript = { "deno_fmt", "prettier" },
		javascriptreact = { "deno_fmt", "prettier" },
		typescriptreact = { "deno_fmt", "prettier" },

		-- Other formats
		css = { "deno_fmt", "prettier" },
		html = { "deno_fmt", "prettier" },
		json = { "deno_fmt", "prettier" },
		yaml = { "deno_fmt", "yamlfix" },
		markdown = { "deno_fmt", "prettier" },
		go = { "gofmt", "goimports-reviser", "golines" },
	},

	-- Format options
	format_on_save = {
		-- Prevent formatting if the file is too large
		timeout_ms = 500,
		lsp_fallback = true,

		-- Only format with Deno in Deno projects
		async = false,
		quiet = false,
		filter = function(client)
			-- Check if we're in a Deno project
			local filename = vim.api.nvim_buf_get_name(0)
			local root = vim.fn.fnamemodify(filename, ":p:h")
			local has_deno_json = vim.fn.filereadable(root .. "/deno.json") == 1
				or vim.fn.filereadable(root .. "/deno.jsonc") == 1

			-- In Deno projects, only use deno_fmt
			if has_deno_json then
				return client == "deno_fmt"
			end

			-- In other projects, use prettier
			return client == "prettier"
		end,
	},
})
