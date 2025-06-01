local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
local plugins = {
	-- LSP
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v3.x",
		dependencies = {
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },

			{ "neovim/nvim-lspconfig" },
			-- Autocompletion
			{ "hrsh7th/nvim-cmp" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "L3MON4D3/LuaSnip" },
			{ "saadparwaiz1/cmp_luasnip" },
			{ "rafamadriz/friendly-snippets" },
		},
	},
	--

	{ "nvim-telescope/telescope.nvim", version = "0.1.4", dependencies = { "nvim-lua/plenary.nvim" } },
	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
	{ "stevearc/conform.nvim", opts = {} },
	{ "stevearc/oil.nvim", opts = {} },
	"lambdalisue/suda.vim",

	{ "nvim-lualine/lualine.nvim", dependencies = { "nvim-tree/nvim-web-devicons", lazy = true } },
	{ "folke/todo-comments.nvim", dependencies = { "nvim-lua/plenary.nvim" }, opts = {} },
	"HiPhish/rainbow-delimiters.nvim",

	"tpope/vim-fugitive",
	"tpope/vim-commentary",
	"tpope/vim-surround",

	"ThePrimeagen/harpoon",
	{
		"phaazon/hop.nvim",
		branch = "v2",
		config = function()
			require("hop").setup()
			vim.keymap.set("n", "gw", ":HopWord<CR>", {})
		end,
	},

	{ "mfussenegger/nvim-dap" },

	-- THEMES
	{ "rose-pine/neovim", name = "rose-pine" },
	{ "vim-scripts/darkbone.vim", name = "darkbone" },
	{ "tpope/vim-vividchalk", name = "vividchalk" },
	{ "mrkn/mrkn256.vim", name = "mrkn256" },
	{ "fneu/breezy", name = "breezy" },
	--
}

local opts = {}
require("lazy").setup(plugins, opts)
