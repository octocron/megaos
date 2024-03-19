--------------------------------------------------------------------------------
-- Markdown Preview
--------------------------------------------------------------------------------
return {
	"iamcco/markdown-preview.nvim",
	ft = "markdown",
	build = function()
		vim.fn["mkdp#util#install"]()
	end,
	keys = {
		{ "<leader>mt", "<cmd>MarkdownPreviewToggle<cr>", desc = "Toggle Preview" },
		{ "<leader>mp", "<cmd>MarkdownPreview<cr>", desc = "Md Preview" },
		{ "<leader>mS", "<cmd>MarkdownPreviewStop<cr>", desc = "Md Preview Stop" },
	},
}
