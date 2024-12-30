return {
	{
		"stevearc/conform.nvim",
		event = "BufWritePre", -- uncomment for format on save
		opts = require("configs.conform"),
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			require("configs.lspconfig")
		end,
	},
	{
		"declancm/cinnamon.nvim",
	  version = "*", -- use latest release
		event = "VimEnter",
		opts = {
			-- change default options here
		},
	},
	{
		"lewis6991/satellite.nvim",
	},
	{
		"lukas-reineke/virt-column.nvim",
		opts = {},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		opts = {
			ensure_installed = {
				"vim",
				"lua",
				"vimdoc",
				"html",
				"css",
			},
		},
	},
}
