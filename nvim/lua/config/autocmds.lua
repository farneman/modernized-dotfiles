-- lua/config/autocmds.lua
-- Direct translations of the old vimrc's autocmd block

local augroup = vim.api.nvim_create_augroup("MyAutocmds", { clear = true })
local au = vim.api.nvim_create_autocmd

-- Per-filetype indent settings (old vimrc's fussy tabs-vs-spaces block)
local ft_indent = {
  make = { ts = 8, sts = 8, sw = 8, et = false },
  yaml = { ts = 2, sts = 2, sw = 2, et = true },
  html = { ts = 2, sts = 2, sw = 2, et = true },
  css = { ts = 2, sts = 2, sw = 2, et = true },
  javascript = { ts = 4, sts = 4, sw = 4, et = true },
  xml = { ts = 4, sts = 4, sw = 4, et = true },
  php = { ts = 4, sts = 4, sw = 4, et = true },
  python = { ts = 4, sts = 4, sw = 4, et = true },
  ruby = { ts = 2, sts = 2, sw = 2, et = true },
}

for ft, cfg in pairs(ft_indent) do
  au("FileType", {
    group = augroup,
    pattern = ft,
    callback = function()
      vim.opt_local.tabstop = cfg.ts
      vim.opt_local.softtabstop = cfg.sts
      vim.opt_local.shiftwidth = cfg.sw
      vim.opt_local.expandtab = cfg.et
    end,
  })
end

-- Treat .rss files as XML (old: autocmd BufNewFile,BufRead *.rss setfiletype xml)
au({ "BufNewFile", "BufRead" }, {
  group = augroup,
  pattern = "*.rss",
  command = "setfiletype xml",
})

-- JS fold settings (old: foldmethod/foldmarker for javascript)
au("FileType", {
  group = augroup,
  pattern = "javascript",
  callback = function()
    vim.opt_local.foldmethod = "marker"
    vim.opt_local.foldmarker = "{,}"
  end,
})

-- Auto change directory to current file's dir (old: autocmd BufEnter * cd %:p:h)
au("BufEnter", {
  group = augroup,
  pattern = "*",
  callback = function()
    local dir = vim.fn.expand("%:p:h")
    if vim.fn.isdirectory(dir) == 1 then
      vim.cmd.lcd(dir)
    end
  end,
})

-- Save folds/view on leaving a buffer (old: au BufWinLeave * mkview)
au("BufWinLeave", {
  group = augroup,
  pattern = "*",
  command = "silent! mkview",
})
