-- Replaces: CtrlP (fuzzy file finder) and Ack.vim (grep search)
return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    config = function()
      local telescope = require("telescope")
      telescope.setup({})
      telescope.load_extension("fzf")

      -- old CtrlP was invoked with <C-p>; keep that muscle memory
      vim.keymap.set("n", "<C-p>", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
      -- old Ack.vim was typically bound to :Ack or <leader>a
      vim.keymap.set("n", "<leader>a", "<cmd>Telescope live_grep<cr>", { desc = "Grep (live)" })
      vim.keymap.set("n", "<leader>b", "<cmd>Telescope buffers<cr>", { desc = "Buffers" })
    end,
  },
}
