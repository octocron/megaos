--------------------------------------------------------------------------------
-- TODO Comments
--------------------------------------------------------------------------------
-- INFO: Install rg;
return {
  {
    -- TODO: makes comments pop!
    -- FIX: this needs fixing
    -- HACK: this seems janky
    -- WARN: give warning about something
    -- NOTE: also informational
    -- PERF: performance or optimise related
    -- TEST: testing pass | fail
    "folke/todo-comments.nvim",
    event = "BufRead",
    keys = {
      { "<leader>tl", "<cmd>TodoLocList<cr>", desc = "Local TODOs List" },
      { "<leader>tq", "<cmd>TodoQuickFix<cr>", desc = "TODOs Quick Fix" },
      { "<leader>ts", "<cmd>TodoTrouble<cr>", desc = "List TODOs with Trouble" },
      { "<leader>tt", "<cmd>TodoTelescope<cr>", desc = "List TODOs with Telescope" },
    },
    config = function()
      require("todo-comments").setup({
        colors = {
          error = { "DiagnosticError", "ErrorMsg", "#880022" },
          test = { "Identifier", "#228800" },
          info = { "DiagnosticInfo", "#2563eb" },
        },
      })
    end,
  },
}
