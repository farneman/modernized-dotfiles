return {
  -- Still maintained, still work perfectly in Neovim unchanged -- no swap needed
  { "tpope/vim-surround" },
  { "tpope/vim-repeat" },
  { "tpope/vim-unimpaired" },
  { "tpope/vim-abolish" },

  -- Replaces: vim-scripts/tComment
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
      -- old vimrc: map <leader>c <c-_><c-_>  (toggle comment)
      vim.keymap.set("n", "<leader>c", function()
        require("Comment.api").toggle.linewise.current()
      end, { desc = "Toggle comment" })
      vim.keymap.set("v", "<leader>c", "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>")
    end,
  },

  -- Replaces: Raimondi/delimitMate
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
  },

  -- Replaces: Lokaltog/vim-easymotion
  -- flash.nvim is the modern standard for this kind of jump-to-anywhere motion
  {
    "folke/flash.nvim",
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash jump" },
    },
  },

  -- Replaces: nathanaelkane/vim-indent-guides
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {},
  },

  -- Replaces: vim-scripts/bufkill.vim
  -- Neovim's native :bd with `hidden` already set (see options.lua) covers
  -- the main use case (closing a buffer without killing the window layout).
  -- No plugin substitute needed.
}
