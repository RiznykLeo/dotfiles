local eslint_filetypes = {
	"javascript",
	"javascriptreact",
	"javascript.jsx",
	"typescript",
	"typescriptreact",
	"typescript.tsx",
}

local eslint_group = vim.api.nvim_create_augroup("ESLintAutofix", { clear = true })

vim.api.nvim_create_autocmd("BufWritePre", {
	group = eslint_group,
	pattern = eslint_filetypes,
	callback = function(args)
		local clients = vim.lsp.get_active_clients({ bufnr = args.buf })
		for _, client in ipairs(clients) do
			if client.name == "eslint" then
				vim.cmd("EslintFixAll")
				return
			end
		end
	end,
	desc = "Run ESLint autofix before saving",
})

