local plugins = {
	{
		"christoomey/vim-tmux-navigator",
		lazy = false,
	},
	{
		"szw/vim-maximizer",
	},

	{
		"williamboman/mason.nvim",
		opts = {
			ensure_installed = {
				"rust-analyzer",
				"prettier",
				"stylua",
				"eslint_d",
				"rustfmt",
				"typescript-language-server",
			},
		},
	},

	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"jose-elias-alvarez/null-ls.nvim",
			config = function()
				require("custom.configs.null-ls")
			end,
		},
		config = function()
			require("plugins.configs.lspconfig")
			require("custom.configs.lspconfig")
		end,
	},
	{
		"lvimuser/lsp-inlayhints.nvim",
		config = function()
			require("custom.configs.inlayhints")
		end,
		event = "LspAttach",
	},

	{
		"rust-lang/rust.vim",
		ft = "rust",
		init = function()
			vim.g.rustfmt_autosave = 1
		end,
		enabled = false,
	},
	{
		"simrat39/rust-tools.nvim",
		ft = "rust",
		dependencies = "neovim/nvim-lspconfig",
		config = function()
			require("custom.configs.rust-tools")
		end,
		-- config = function(_, opts)
		--   require("rust-tools").setup(opts)
		-- end,
	},
	{
		"saecki/crates.nvim",
		dependencies = "hrsh7th/nvim-cmp",
		ft = { "rust", "toml" },
		config = function(_, opts)
			local crates = require("crates")
			crates.setup(opts)
			crates.show()
		end,
	},

	{
		"hrsh7th/nvim-cmp",
		opts = function()
			local M = require("plugins.configs.cmp")
			table.insert(M.sources, { name = "crates" })
			return M
		end,
	},

	{
		"mfussenegger/nvim-dap",
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = "mfussenegger/nvim-dap",
	},

	{
		"folke/which-key.nvim",
		enabled = false,
	},
	{
		"NvChad/nvim-colorizer.lua",
		enabled = false,
	},

	{
		"nvim-tree/nvim-tree.lua",
		opts = function()
			return require("custom.configs.nvimtree")
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter",
		opts = function()
			return require("custom.configs.treesitter")
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		dependencies = "nvim-treesitter/nvim-treesitter",
		init = require("core.utils").lazy_load("nvim-treesitter-textobjects"),
	},
	{
		"windwp/nvim-ts-autotag",
		dependencies = "nvim-treesitter/nvim-treesitter",
		ft = {
			"html",
			"javascript",
			"typescript",
			"javascriptreact",
			"typescriptreact",
			"svelte",
			"vue",
			"tsx",
			"jsx",
			"rescript",
			"xml",
			"php",
			"markdown",
			"astro",
			"glimmer",
			"handlebars",
			"hbs",
		},
	},
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({})
		end,
	},

	{
		"mbbill/undotree",
		lazy = false,
	},

	{
		"andweeb/presence.nvim",
		opts = {
			main_image = "file",
			neovim_image_text = "I don't know how to exit Vim",
		},
		lazy = false,
	},
}

return plugins
