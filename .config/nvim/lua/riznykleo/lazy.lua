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
	-- LSP & COMPLETION
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

	-- SYNTAX & PARSING
	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
	"HiPhish/rainbow-delimiters.nvim",
	{
		"windwp/nvim-ts-autotag",
		dependencies = "nvim-treesitter/nvim-treesitter",
		config = function()
			require("nvim-ts-autotag").setup({
				opts = {
					enable_close = true, -- Auto close tags
					enable_rename = true, -- Auto rename pairs of tags
					enable_close_on_slash = true, -- Auto close on trailing </
				},
			})
		end,
	},

	-- NAVIGATION & SEARCH
	{ "nvim-telescope/telescope.nvim", version = "0.1.4", dependencies = { "nvim-lua/plenary.nvim" } },
	{ "stevearc/oil.nvim", opts = {} },
	"ThePrimeagen/harpoon",
	{
		"phaazon/hop.nvim",
		branch = "v2",
		config = function()
			require("hop").setup()
			vim.keymap.set("n", "gw", ":HopWord<CR>", {})
		end,
	},
	{ "chentoast/marks.nvim" },

	-- EDITING & TEXT MANIPULATION
	{ "stevearc/conform.nvim", opts = {} },
	{
		"echasnovski/mini.pairs",
		version = false,
		config = function()
			require("mini.pairs").setup()
		end,
	},
	"tpope/vim-commentary",
	"tpope/vim-surround",

	-- GIT INTEGRATION
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
		end,
	},
	{
		"tpope/vim-fugitive",
		config = function()
			vim.keymap.set("n", "<leader>gs", vim.cmd.Git, { desc = "Git status" })
		end,
	},

	-- UI & VISUAL
	{ "nvim-lualine/lualine.nvim", dependencies = { "nvim-tree/nvim-web-devicons", lazy = true } },
	{ "folke/todo-comments.nvim", dependencies = { "nvim-lua/plenary.nvim" }, opts = {} },

	-- DEBUGGING
	{ "mfussenegger/nvim-dap" },

	-- UTILITIES
	"lambdalisue/suda.vim",

	-- THEMES
	{ "rose-pine/neovim", name = "rose-pine" },
	{ "vim-scripts/darkbone.vim", name = "darkbone" },
	{ "tpope/vim-vividchalk", name = "vividchalk" },
	{ "mrkn/mrkn256.vim", name = "mrkn256" },
	{ "fneu/breezy", name = "breezy" },
}

local opts = {}
require("lazy").setup(plugins, opts)
