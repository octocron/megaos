--------------------------------------------------------------------------------
-- Glow
--------------------------------------------------------------------------------
return {
	{
		"ellisonleao/glow.nvim",
		config = function()
---@diagnostic disable-next-line: missing-fields
			require("glow").setup({
				cmd = "Glow",
				style = "dark",
				width = 120,
			})
		end,
	},
}
