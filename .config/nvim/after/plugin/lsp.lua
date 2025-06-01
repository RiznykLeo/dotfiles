local lsp = require("lsp-zero")

local js_ts_filetypes = {
	"javascript",
	"javascriptreact",
	"javascript.jsx",
	"typescript",
	"typescriptreact",
	"typescript.tsx",
}

local diagnostic_float_opts = {
	focusable = false,
	close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
	border = "rounded",
	source = "always",
	prefix = "",
}

-- Mason
require("mason").setup({})
require("mason-lspconfig").setup({
	ensure_installed = { "ts_ls", "eslint@4.8.0" },
	handlers = {
		lsp.default_setup,
		lua_ls = function()
			local lua_opts = lsp.nvim_lua_ls()
			require("lspconfig").lua_ls.setup(lua_opts)
		end,
	},
})

-- LSPs
local nvim_lsp = require("lspconfig")

nvim_lsp.ts_ls.setup({
	root_dir = nvim_lsp.util.root_pattern("package.json"),
	single_file_support = false,
})

nvim_lsp.eslint.setup({
	settings = {
		workingDirectory = { mode = "auto" },
	},
	root_dir = nvim_lsp.util.root_pattern(
		".eslintrc",
		".eslintrc.js",
		".eslintrc.json",
		".eslintrc.yaml",
		".eslintrc.yml",
		"eslint.config.js",
		"package.json"
	),
	filetypes = js_ts_filetypes,
})

nvim_lsp.biome.setup({
	autostart = false,
})

nvim_lsp.relay_lsp.setup({
	auto_start_compiler = false,
	path_to_config = nil,
	root_dir = nvim_lsp.util.root_pattern("relay.config.*", "package.json"),
	filetypes = js_ts_filetypes,
})

-- LSP preferences
lsp.set_preferences({
	suggest_lsp_servers = true,
	sign_icons = {
		error = "E",
		warn = "W",
		hint = "H",
		info = "I",
	},
})

lsp.on_attach(function(client, bufnr)
	lsp.default_keymaps({ buffer = bufnr })

	local function keymap_opts(desc)
		return { buffer = bufnr, remap = false, desc = desc }
	end

	vim.keymap.set("n", "gd", vim.lsp.buf.definition, keymap_opts("Go to definition"))
	vim.keymap.set("n", "K", vim.lsp.buf.hover, keymap_opts("Show hover information"))
	vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, keymap_opts("Search workspace symbols"))
	vim.keymap.set({ "n", "v" }, "<leader>vca", vim.lsp.buf.code_action, keymap_opts("Show code actions"))
	vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, keymap_opts("Show references"))
	vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, keymap_opts("Rename symbol"))
	vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, keymap_opts("Show signature help"))

	vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, keymap_opts("Go to previous diagnostic"))
	vim.keymap.set("n", "]d", vim.diagnostic.goto_next, keymap_opts("Go to next diagnostic"))
	vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, keymap_opts("Show line diagnostics"))
	vim.keymap.set("n", "<leader>dq", vim.diagnostic.setqflist, keymap_opts("Open diagnostics quickfix (project)"))
	vim.keymap.set("n", "<leader>dl", vim.diagnostic.setloclist, keymap_opts("Open diagnostics loclist (buffer)"))
end)

-- Setup LSP
lsp.setup()

-- Diagnostic configuration
vim.diagnostic.config({
	virtual_text = {
		spacing = 4,
		source = "if_many",
		prefix = "●",
		format = function(diagnostic)
			local message = diagnostic.message:match("^[^\n]*") or diagnostic.message
			return message
		end,
	},
	float = vim.tbl_extend("force", diagnostic_float_opts, {
		header = "",
	}),
	signs = true,
	update_in_insert = false,
	severity_sort = true,
})

vim.api.nvim_create_autocmd("CursorHold", {
	callback = function()
		vim.diagnostic.open_float(
			nil,
			vim.tbl_extend("force", diagnostic_float_opts, {
				scope = "cursor",
			})
		)
	end,
})

vim.opt.updatetime = 300

-- ESLint autofix on save
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = js_ts_filetypes,
	callback = function()
		vim.cmd("EslintFixAll")
	end,
})
