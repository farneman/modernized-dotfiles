-- badwolf is a pure-Vimscript colorscheme; it loads in Neovim with zero changes
return {
  {
    "sjl/badwolf",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("badwolf")
    end,
  },
}
