-- Replaces: pangloss/vim-javascript and jelera/vim-javascript-syntax
-- Treesitter gives faster, more accurate highlighting than regex-based
-- syntax files, and covers every language from one plugin.
return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      ensure_installed = {
        "lua", "vim", "vimdoc",
        "python", "javascript", "typescript", "html", "css",
        "yaml", "json", "markdown", "bash",
      },
      highlight = { enable = true },
      indent = { enable = true },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
}
