--------------------------------------------------------------------------------
-- Harpoon 2
--------------------------------------------------------------------------------
return {
	{
		"ThePrimeagen/harpoon",
		lazy = false,
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("telescope").load_extension("harpoon")
			require("harpoon").setup({
				keys = {
					{
						"<leader>hm",
						"<cmd>lua require('harpoon.mark').add_file()<cr>",
						desc = "Harpoon Mark File",
					},
					{
						"<leader>hl",
						"<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>",
						desc = "Harpoon List Marks",
					},

					{
						"<leader>1",
						"<cmd>lua require('harpoon.ui').nav_file(1)<cr>",
						desc = "Harpoon buffer 1",
					},
					{
						"<leader>2",
						"<cmd>lua require('harpoon.ui').nav_file(2)<cr>",
						desc = "Harpoon buffer 2",
					},
					{
						"<leader>3",
						"<cmd>lua require('harpoon.ui').nav_file(3)<cr>",
						desc = "Harpoon buffer 3",
					},
					{
						"<leader>4",
						"<cmd>lua require('harpoon.ui').nav_file(4)<cr>",
						desc = "Harpoon buffer 4",
					},
				},
			})
			vim.cmd("highlight! HarpoonInactive guibg=NONE guifg=#63698C")
			vim.cmd("highlight! HarpoonActive guibg=NONE guifg=#FFB86C")
			vim.cmd("highlight! HarpoonNumberActive guibg=NONE guifg=##50FA7B")
			vim.cmd("highlight! HarpoonNumberInactive guibg=NONE guifg=#61AFEF")
			vim.cmd("highlight! TabLineFill guibg=NONE guifg=#FFB86C")
		end,
	},
}
