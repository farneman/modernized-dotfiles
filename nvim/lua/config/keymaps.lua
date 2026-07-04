-- lua/config/keymaps.lua
-- Direct translations of the custom mappings from the old vimrc

local map = vim.keymap.set

-- Escape insert mode with jj (old: imap jj <esc>)
map("i", "jj", "<esc>", { desc = "Escape insert mode" })

-- Map spacebar to colon (old: nmap <space> :)
map("n", "<space>", ":", { desc = "Command mode shortcut" })

-- Hard-wrap current paragraph (old: nnoremap <leader>q gqip)
map("n", "<leader>q", "gqip", { desc = "Hard-wrap paragraph" })

-- Edit / reload config (old: <leader>ev + autocmd bufwritepost)
map("n", "<leader>ev", ":tabedit $MYVIMRC<cr>", { desc = "Edit init.lua" })
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "init.lua",
  command = "source <afile>",
})

-- Window nav (old: nmap <C-h/j/k/l> <C-w>h/j/k/l)
map("n", "<C-h>", "<C-w>h", { desc = "Window left" })
map("n", "<C-j>", "<C-w>j", { desc = "Window down" })
map("n", "<C-k>", "<C-w>k", { desc = "Window up" })
map("n", "<C-l>", "<C-w>l", { desc = "Window right" })

-- Vertical split + switch (old: nnoremap <leader>v <C-w>v<C-w>l)
map("n", "<leader>v", "<C-w>v<C-w>l", { desc = "Vertical split" })

-- Belowright vsplit (old: nmap <leader>bv :bel vsp)
map("n", "<leader>bv", ":belowright vsplit<cr>", { desc = "Belowright vsplit" })

-- cd shortcuts (old: <leader>d for Desktop, <leader>hm for home)
map("n", "<leader>d", ":cd ~/Desktop<cr>:e.<cr>", { desc = "cd to Desktop" })
map("n", "<leader>hm", ":cd ~/<cr>", { desc = "cd to home" })

-- Bubble single lines (old: nmap <C-Up>/<C-Down> ddkP / ddp)
map("n", "<C-Up>", "ddkP", { desc = "Bubble line up" })
map("n", "<C-Down>", "ddp", { desc = "Bubble line down" })
-- Bubble multiple lines (visual mode)
map("v", "<C-Up>", "xkP`[V`]", { desc = "Bubble selection up" })
map("v", "<C-Down>", "xp`[V`]", { desc = "Bubble selection down" })

-- Filetype switchers (old: nnoremap _dt / _pd / _ss / _r)
map("n", "_dt", ":set ft=htmldjango<cr>", { desc = "Filetype: htmldjango" })
map("n", "_pd", ":set ft=python<cr>", { desc = "Filetype: python" })
map("n", "_ss", ":set ft=scss<cr>", { desc = "Filetype: scss" })
map("n", "_r", ":retab!<cr>", { desc = "Retab file" })

-- Print empty <a> tag (old: map! ;h <a href=""></a><ESC>5hi)
map("!", ";h", '<a href=""></a><ESC>5hi', { desc = "Insert empty anchor tag" })

-- Abbreviations (old: iab lorem / llorem / teh / Teh)
vim.cmd([[
  iabbrev lorem Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
  iabbrev llorem Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.
  iabbrev teh the
  iabbrev Teh The
]])

-- NOTE: NERDTree, CtrlP, Ack, comment-toggle, and fold-tag mappings
-- now live in their respective plugin spec files in lua/plugins/,
-- since each depends on a plugin being loaded first.
