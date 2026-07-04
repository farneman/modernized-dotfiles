-- Replaces: scrooloose/nerdtree
return {
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({
        filters = { dotfiles = false }, -- old: let NERDTreeShowHidden=1
      })
      -- old: nmap <leader>nt :NERDTreeToggle <CR>
      vim.keymap.set("n", "<leader>nt", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle file tree" })
    end,
  },

  -- New addition -- old vimrc relied on `set laststatus=2` with the default
  -- statusline. lualine gives you git branch, mode, and diagnostics for free.
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = { options = { theme = "auto" } },
  },
}
