--------------------------------------------------------------------------------
-- Color Scheme
--------------------------------------------------------------------------------
return {
  {
    "tiagovla/tokyodark.nvim",
    opts = {
        -- custom options here
        priority = 1000,
    },
    config = function(_, opts)
        require("tokyodark").setup(opts) -- calling setup is optional
        vim.cmd [[colorscheme tokyodark]]
    end,
  }
}
