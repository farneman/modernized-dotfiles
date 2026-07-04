-- Replaces: YouCompleteMe, Syntastic, pyflakes-vim, tern_for_vim
-- LSP gives you completion + real-time diagnostics from one source per language,
-- instead of stitching together a linter plugin and a separate completion engine.
return {
  {
    "williamboman/mason.nvim",
    config = true,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "mason.nvim" },
    opts = {
      ensure_installed = {
        "pyright",        -- Python (replaces YouCompleteMe + pyflakes-vim)
        "ts_ls",           -- JS/TS (replaces tern_for_vim)
        "html",
        "cssls",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = { "mason-lspconfig.nvim", "hrsh7th/cmp-nvim-lsp" },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local lspconfig = require("lspconfig")

      for _, server in ipairs({ "pyright", "ts_ls", "html", "cssls" }) do
        lspconfig[server].setup({ capabilities = capabilities })
      end

      -- Diagnostics shown inline, replacing Syntastic's gutter signs
      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = true,
        severity_sort = true,
      })

      -- Standard LSP keymaps (old vimrc had none of these because
      -- YouCompleteMe/tern didn't offer them without extra config)
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
      vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover docs" })
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
    end,
  },
}
