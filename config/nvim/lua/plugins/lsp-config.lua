--------------------------------------------------------------------------------
-- Mason
--------------------------------------------------------------------------------
return {
  -- INFO:Installs Mason
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  -- INFO: bridge for mason with lspconfig plugin by installing servers on your system
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    opts = {
      auto_install = true,
    },
  },
  -- INFO: the actual lsp plugin
  {
    "neovim/nvim-lspconfig",
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local lspconfig = require("lspconfig")

      lspconfig.golangci_lint_ls.setup({
        capabilities = capabilities,
      })
      lspconfig.gopls.setup({
        capabilities = capabilities,
      })
      lspconfig.html.setup({
        capabilities = capabilities,
      })
      lspconfig.nil_ls.setup({
        capabilities = capabilities,
        settings = {
          nix = {
            autoArchive = true,
          },
        },
      })
      lspconfig.rust_analyzer.setup({
        capabilities = capabilities,
      })
      lspconfig.taplo.setup({
        capabilities = capabilities,
      })
      lspconfig.lua_ls.setup({
        settings = {
          Lua = {
            runtime = {
              version = "LuaJIT",
            },
            diagnostics = {
              -- Get the language server to recognize the `vim` global
              globals = {
                "vim",
                "require",
              },
            },
            workspace = {
              -- Make the server aware of Neovim runtime files
              library = vim.api.nvim_get_runtime_file("", true),
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
              enable = false,
            },
          },
        },
      })
      vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "lsp buffer hover" })
      vim.keymap.set("n", "<leader>ld", vim.lsp.buf.definition, { desc = "lsp definition" })
      vim.keymap.set("n", "<leader>li", vim.lsp.buf.implementation, { desc = "lsp implementation" })
      vim.keymap.set("n", "<leader>lr", vim.lsp.buf.references, { desc = "lsp references" })
      vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "code action" })
    end,
  },
}
