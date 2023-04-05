local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

local status, packer = pcall(require, "packer")
if not status then
	return
end

return packer.startup(function(use)
	use("wbthomason/packer.nvim")
	use("nvim-lua/plenary.nvim")

	-- themes
	use({ "catppuccin/nvim", as = "catppuccin" })

	-- tmux & windows
	use({ "christoomey/vim-tmux-navigator" })
	use({ "szw/vim-maximizer" })

	use({ "tpope/vim-surround" })

	-- commenting with gc
	use({ "numToStr/Comment.nvim" })

	-- file explorer
	use({ "nvim-tree/nvim-tree.lua" })
	use({ "nvim-tree/nvim-web-devicons" }) -- vscode icons

	-- lualine
	use({ "nvim-lualine/lualine.nvim" })

	-- telescope & fzfinding
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
	use({ "nvim-telescope/telescope.nvim", branch = "0.1.x" })

	-- LSP
	use({
		"VonHeikemen/lsp-zero.nvim",
		branch = "v2.x",
		requires = {
			-- LSP Support
			{ "neovim/nvim-lspconfig" },
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },

			-- Autocompletion
			{ "hrsh7th/nvim-cmp" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "saadparwaiz1/cmp_luasnip" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-nvim-lua" },

			-- Snippets
			{ "L3MON4D3/LuaSnip" },
			-- Snippet Collection (Optional)
			{ "rafamadriz/friendly-snippets" },
			-- Inlayhints
			{ "lvimuser/lsp-inlayhints.nvim" },
			-- Rust tools
			{ "simrat39/rust-tools.nvim" },
		},
	})
	use({ "onsails/lspkind.nvim" })

	-- treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
			ts_update()
		end,
	})

	-- autoclosing
	use({ "windwp/nvim-autopairs" })
	use({ "windwp/nvim-ts-autotag", after = "nvim-treesitter" })

	-- null ls
	use({ "jose-elias-alvarez/null-ls.nvim" })
	use({ "jayp0521/mason-null-ls.nvim" })

	-- git integrations
	use({ "lewis6991/gitsigns.nvim" })
	use({ "tpope/vim-fugitive" })

	-- bufferline
	use({ "akinsho/bufferline.nvim", tag = "v3.*", requires = "nvim-tree/nvim-web-devicons" })

	use({ "mbbill/undotree" })

	use({ "andweeb/presence.nvim" })

	use({
		"iamcco/markdown-preview.nvim",
		run = "cd app && npm install",
		setup = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	})

	use({ "mfussenegger/nvim-dap" })

	use({ "norcalli/nvim-colorizer.lua" })

	if packer_bootstrap then
		require("packer").sync()
	end
end)
