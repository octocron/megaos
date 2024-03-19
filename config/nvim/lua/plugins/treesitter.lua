--------------------------------------------------------------------------------
-- Treesitter
--------------------------------------------------------------------------------
return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		local config = require("nvim-treesitter.configs")
		config.setup({
			auto_install = true,
			ignore_install = { "cobol" },
			sync_install = false,
			ensure_installed = {
				"bash",
				"css",
				"dockerfile",
				"c",
				"go",
				"html",
				"javascript",
				"json",
				"lua",
				"markdown",
				"markdown_inline",
				"nix",
				"python",
				"regex",
				"rust",
				"terraform",
				"toml",
				"query",
				"yaml",
				"vim",
				"vimdoc",
			},
			highlight = { enable = true },
			indent = { enable = true },
			autotag = { enable = true },
		})
	end,
}
