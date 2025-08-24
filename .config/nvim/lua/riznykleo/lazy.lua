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

	-- LANGUAGE SPECIFIC PLUGINS
	--
	-- RUST
	{
		"rust-lang/rust.vim",
		ft = "rust",
		init = function()
			vim.g.rustfmt_autosave = 1
		end,
	},
	{
		"mrcjkb/rustaceanvim",
		version = "^6",
		lazy = false, -- This plugin is already lazy
	},
	{
		"saecki/crates.nvim",
		ft = { "toml" },
		config = function()
			require("crates").setup({
				completion = {
					cmp = {
						enabled = true,
					},
				},
			})
			require("cmp").setup.buffer({
				sources = { { name = "crates" } },
			})
		end,
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
	{
		"mfussenegger/nvim-dap",
		config = function()
			local dap, dapui = require("dap"), require("dapui")
			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end
		end,
	},

	{
		"rcarriga/nvim-dap-ui",
		dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
		config = function()
			require("dapui").setup()
		end,
	},

	-- UTILITIES
	"lambdalisue/suda.vim",

	-- THEMES
	{ "rose-pine/neovim", name = "rose-pine" },
	{ "tpope/vim-vividchalk", name = "vividchalk" },
	{ "mrkn/mrkn256.vim", name = "mrkn256" },
	{ "fneu/breezy", name = "breezy" },
}

local opts = {}
require("lazy").setup(plugins, opts)
