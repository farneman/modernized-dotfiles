-- Replaces: tpope/vim-obsession
--
-- Obsession worked by you manually running :Obsession to start recording a
-- Session.vim file, which tmux-resurrect then knew how to reload via
-- `@resurrect-strategy-vim 'session'`.
--
-- persistence.nvim removes the manual step: it saves a session automatically
-- for every project directory on exit, keyed by cwd, and reloads it
-- automatically when you open Neovim with no file arguments in that same
-- directory. Nothing to remember to turn on.
--
-- This also decouples session restore from tmux-resurrect entirely -- see
-- tmux/.tmux.conf, which now just relaunches the `nvim` process, and
-- persistence.nvim's own VimEnter autocmd takes it from there.
return {
  {
    "folke/persistence.nvim",
    event = "VimEnter",
    opts = {
      dir = vim.fn.stdpath("state") .. "/sessions/",
    },
    config = function(_, opts)
      require("persistence").setup(opts)

      -- Auto-restore when nvim is opened with no file args (e.g. `nvim`
      -- inside a project dir, or a tmux-resurrect-relaunched pane)
      vim.api.nvim_create_autocmd("VimEnter", {
        group = vim.api.nvim_create_augroup("PersistenceAutoRestore", { clear = true }),
        nested = true,
        callback = function()
          if vim.fn.argc() == 0 then
            require("persistence").load()
          end
        end,
      })

      -- old: :Obsession toggled recording; these are the closest Lua equivalents
      vim.keymap.set("n", "<leader>ss", function() require("persistence").load() end, { desc = "Restore session" })
      vim.keymap.set("n", "<leader>sl", function() require("persistence").load({ last = true }) end, { desc = "Restore last session" })
      vim.keymap.set("n", "<leader>sd", function() require("persistence").stop() end, { desc = "Stop saving this session" })
    end,
  },
}
