local lsp = require("lsp-zero")

local js_ts_filetypes = {
	"javascript",
	"javascriptreact",
	"javascript.jsx",
	"typescript",
	"typescriptreact",
	"typescript.tsx",
	"astro",
}
local graphql_filetypes = {
	"graphql",
}
local js_ts_graphql_filetypes = vim.list_extend(vim.deepcopy(js_ts_filetypes), graphql_filetypes)

local blink_cmp = require("blink.cmp")

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
	ensure_installed = { "ts_ls", "eslint@4.8.0", "graphql", "lua_ls" },
	automatic_enable = true,
	handlers = {
		lsp.default_setup,
	},
})

-- Configure lua_ls separately with Neovim runtime
vim.lsp.config("lua_ls", {
	capabilities = blink_cmp.get_lsp_capabilities(), -- ADD THIS LINE
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
			},
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
				checkThirdParty = false,
			},
			telemetry = {
				enable = false,
			},
		},
	},
})

-- LSPs using new vim.lsp.config API
vim.lsp.config("ts_ls", {
	capabilities = blink_cmp.get_lsp_capabilities(), -- ADD THIS LINE
	root_markers = { "package.json" },
	single_file_support = false,
})

vim.lsp.config("eslint", {
	capabilities = blink_cmp.get_lsp_capabilities(), -- ADD THIS LINE
	settings = {
		workingDirectory = { mode = "auto" },
	},
	root_markers = {
		".eslintrc",
		".eslintrc.js",
		".eslintrc.json",
		".eslintrc.yaml",
		".eslintrc.yml",
		"eslint.config.js",
		"package.json",
	},
	filetypes = js_ts_graphql_filetypes,

	on_attach = function(client, bufnr)
		vim.api.nvim_create_autocmd("BufWritePre", {
			buffer = bufnr,
			callback = function()
				vim.lsp.buf.code_action({
					context = { only = { "source.fixAll.eslint" }, diagnostics = {} },
					apply = true,
				})
			end,
		})
	end,
})

-- GraphQL LSP setup
vim.lsp.config("graphql", {
	capabilities = blink_cmp.get_lsp_capabilities(), -- ADD THIS LINE
	filetypes = js_ts_graphql_filetypes,
	root_markers = { "schema.graphql", "package.json", ".graphqlrc.yml" },
})

vim.lsp.config("relay_lsp", {
	capabilities = blink_cmp.get_lsp_capabilities(), -- ADD THIS LINE
	cmd = { "relay-compiler", "lsp" },
	root_markers = { "relay.config.*" },
	filetypes = js_ts_graphql_filetypes,
	settings = {
		auto_start_compiler = false,
		path_to_config = nil,
	},
})

-- Pyright (remove duplicate setup)
vim.lsp.config("pyright", {
	capabilities = blink_cmp.get_lsp_capabilities(), -- ADD THIS LINE
	root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", "Pipfile", ".git" },
	settings = {
		python = {
			pythonPath = vim.fn.getcwd() .. "/.venv/bin/python",
			analysis = {
				autoSearchPaths = true,
				useLibraryCodeForTypes = true,
				diagnosticMode = "workspace",
			},
		},
	},
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

	vim.keymap.set("n", "<leader>dy", function()
		local diagnostics = vim.diagnostic.get(0, { lnum = vim.fn.line(".") - 1 })
		if #diagnostics > 0 then
			local message = diagnostics[1].message
			vim.fn.setreg("+", message)
			print("Copied diagnostic to clipboard: " .. message:sub(1, 50) .. "...")
		else
			print("No diagnostic on current line")
		end
	end, keymap_opts("Copy diagnostic to clipboard"))

	-- Crates
	vim.keymap.set("n", "<leader>cr", function()
		require("crates").reload()
	end, keymap_opts("Reload crates"))

	vim.keymap.set("n", "<leader>cu", function()
		require("crates").update_crate()
	end, keymap_opts("Update crate"))

	vim.keymap.set("n", "<leader>cU", function()
		require("crates").update_all_crates()
	end, keymap_opts("Update all crates"))
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

-- Enable LSP servers on appropriate filetypes
vim.lsp.enable("ts_ls")
vim.lsp.enable("eslint")
vim.lsp.enable("graphql")
vim.lsp.enable("relay_lsp")
vim.lsp.enable("pyright")
