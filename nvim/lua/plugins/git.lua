return {
  -- Still the best git plugin for Vim/Neovim, unchanged
  { "tpope/vim-fugitive" },

  -- gitsigns is the modern addition Fugitive never covered: inline
  -- git status in the gutter (added/changed/removed lines)
  {
    "lewis6991/gitsigns.nvim",
    config = true,
  },
}
