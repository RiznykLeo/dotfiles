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
	{ "mfussenegger/nvim-dap" },
	{ "nvim-lualine/lualine.nvim", dependencies = { "nvim-tree/nvim-web-devicons", lazy = true } },
	{ "folke/todo-comments.nvim", dependencies = { "nvim-lua/plenary.nvim" }, opts = {} },
	{ "kevinhwang91/nvim-ufo", dependencies = { "kevinhwang91/promise-async" } }, --folds
	"ThePrimeagen/harpoon",
	"lambdalisue/suda.vim",
	"HiPhish/rainbow-delimiters.nvim",
	"tpope/vim-fugitive",
	"tpope/vim-commentary",
	"tpope/vim-surround",

	{
		"m4xshen/hardtime.nvim",
		dependencies = { "MunifTanjim/nui.nvim" },
		opts = {},
	}, -- to disable ":Hardtime disable" or ":Hardtime toggle"

	-- GO
	{
		"leoluz/nvim-dap-go",
		ft = "go",
		dependencies = "mfussenegger/nvim-dap",
		config = function(_, opts)
			require("dap-go").setup(opts)
		end,
	},
	{
		"olexsmir/gopher.nvim",
		ft = "go",
		config = function(_, opts)
			require("gopher").setup(opts)
		end,
		build = function()
			vim.cmd.GoInstallDeps()
		end,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"mfussenegger/nvim-dap", -- (optional) only if you use `gopher.dap`
		},
	},
	--

	-- THEMES
	{ "rose-pine/neovim", name = "rose-pine" },
	{ "vim-scripts/darkbone.vim", name = "darkbone" },
	{ "tpope/vim-vividchalk", name = "vividchalk" },
	{ "mrkn/mrkn256.vim", name = "mrkn256" },
	{ "fneu/breezy", name = "breezy" },
	--

	-- AI
	-- {
	-- 	"yetone/avante.nvim",
	-- 	event = "VeryLazy",
	-- 	lazy = false,
	-- 	version = false, -- set this if you want to always pull the latest change
	-- 	opts = {
	-- 		-- add any opts here
	-- 	},
	-- 	-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
	-- 	build = "make",
	-- 	-- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
	-- 	dependencies = {
	-- 		"nvim-treesitter/nvim-treesitter",
	-- 		"stevearc/dressing.nvim",
	-- 		"nvim-lua/plenary.nvim",
	-- 		"MunifTanjim/nui.nvim",
	-- 		--- The below dependencies are optional,
	-- 		"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
	-- 		"zbirenbaum/copilot.lua", -- for providers='copilot'
	-- 		{
	-- 			-- support for image pasting
	-- 			"HakonHarnes/img-clip.nvim",
	-- 			event = "VeryLazy",
	-- 			opts = {
	-- 				-- recommended settings
	-- 				default = {
	-- 					embed_image_as_base64 = false,
	-- 					prompt_for_file_name = false,
	-- 					drag_and_drop = {
	-- 						insert_mode = true,
	-- 					},
	-- 					-- required for Windows users
	-- 					use_absolute_path = true,
	-- 				},
	-- 			},
	-- 		},
	-- 	},
	-- },
}

local opts = {}
require("lazy").setup(plugins, opts)
