# Modernized MacVim + tmux setup

Direct successor to `farneman/myvim` + `farneman/mytmux.conf`, translated to
Neovim + lazy.nvim. See the comments in each file for the old → new mapping.

## 1. Install Ghostty

```bash
brew install --cask ghostty
```

## 2. Install Neovim and tmux via Homebrew

```bash
brew install neovim tmux
brew install ripgrep fd     # needed by Telescope's live_grep/find_files
brew install fzf            # needed by telescope-fzf-native
```

## 3. Install language runtimes via mise

The LSP servers (pyright, ts_ls) need Node and Python available. If you
don't already have mise set up:

```bash
brew install mise
```

Add this to your shell config (e.g. `~/.zshrc`):

```bash
eval "$(mise activate zsh)"
```

Then install the runtimes:

```bash
mise use -g node@latest
mise use -g python@latest
```

Mason (the plugin that installs pyright/ts_ls inside Neovim) shells out to
`node` and `python`/`pip`, so these need to resolve on your `PATH` before
you open Neovim for the first time. Confirm with:

```bash
which node python3
```

## 4. Install a Nerd Font (for file icons in nvim-tree/lualine)

```bash
brew install --cask font-jetbrains-mono-nerd-font
```

Then set your terminal (iTerm2/Terminal.app/Ghostty/etc.) to use
"JetBrainsMono Nerd Font" so the icons render instead of showing as boxes.

## 5. Install Starship prompt

```bash
brew install starship
```

Add this to your shell config (e.g. `~/.zshrc`), after any `oh-my-zsh`/theme
sourcing so it takes over the prompt last:

```bash
eval "$(starship init zsh)"
```

## 6. Place the config files

Run these from the top level of this repo (the source paths below are
relative to it):

```bash
mkdir -p ~/.config/nvim
cp -r ./nvim/* ~/.config/nvim/

cp ./tmux/.tmux.conf ~/.tmux.conf

mkdir -p ~/.config/ghostty/themes
cp ./ghostty/config ~/.config/ghostty/config
cp ./ghostty/themes/badwolf ~/.config/ghostty/themes/badwolf

cp ./starship.toml ~/.config/starship.toml
```

## 7. Install tpm (tmux plugin manager)

```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

Start tmux, then press `prefix + I` (that's `Ctrl-a` then capital `I`,
matching the remapped prefix in the config) to fetch tmux-sensible,
tmux-copycat, tmux-yank, tmux-open, tmux-resurrect, and tmux-continuum.

## 8. First Neovim launch

```bash
nvim
```

lazy.nvim bootstraps itself on first run and installs every plugin
automatically — you'll see a install progress window. Once it finishes,
restart Neovim, then run:

```
:Mason
```

and confirm `pyright` and `ts_ls` show as installed (mason-lspconfig
installs them automatically on first launch, but `:Mason` lets you verify
or add more servers later).

## 9. Optional: bring over your custom CSS snippets

Your old `farneman/vim-ultisnips-css` repo is UltiSnips-format snippets.
LuaSnip can load them without rewriting:

```bash
git clone https://github.com/farneman/vim-ultisnips-css ~/.config/nvim/snippets
```

Then uncomment this line in `nvim/lua/plugins/completion.lua`:

```lua
require("luasnip.loaders.from_snipmate").lazy_load({ paths = { "~/.config/nvim/snippets" } })
```

## What changed vs. your old setup, at a glance

| Old | New |
|---|---|
| Vundle | lazy.nvim |
| YouCompleteMe | nvim-cmp + pyright (via mason) |
| Syntastic + pyflakes-vim | native LSP diagnostics |
| tern_for_vim | ts_ls (typescript-language-server) |
| NERDTree | nvim-tree.lua |
| CtrlP | Telescope (`<C-p>`) |
| Ack.vim | Telescope live_grep (`<leader>a`) |
| UltiSnips + vim-ultisnips-css | LuaSnip (loads your old snippets as-is) |
| delimitMate | nvim-autopairs |
| tComment | Comment.nvim (`<leader>c`) |
| vim-indent-guides | indent-blankline.nvim |
| vim-easymotion | flash.nvim (`s`) |
| vim-javascript / vim-javascript-syntax | nvim-treesitter |
| bufkill.vim | native `:bd` (already covered by `set hidden`) |
| tpope stack (fugitive, surround, repeat, unimpaired, abolish) | unchanged, all still maintained |
| badwolf colorscheme | unchanged, still a plain Vimscript colorscheme |
| tmux prefix/keybindings/window names | unchanged |
| vim-obsession | persistence.nvim |
| tmux-resurrect's `@resurrect-strategy-vim 'session'` | `@resurrect-processes 'nvim'` |
| reattach-to-user-namespace | removed — unnecessary on modern macOS |
| `bind -t vi-copy` | updated to `-T copy-mode-vi` key table syntax |
| django.py filetype detection | removed |

### How sessions work now

Old flow: run `:Obsession` manually in Neovim to start recording a
`Session.vim`, and tmux-resurrect knew to reload that specific file via
`@resurrect-strategy-vim 'session'`.

New flow: `persistence.nvim` auto-saves a session for every project
directory on exit — no command to remember. tmux-resurrect's job shrinks to
just relaunching the `nvim` process in each restored pane
(`@resurrect-processes 'nvim'`); Neovim then auto-restores that directory's
session itself the moment it opens with no file arguments. The two tools no
longer need to know about each other's file formats.

Manual controls, if you want them:
- `<leader>ss` — restore session for the current directory
- `<leader>sl` — restore the last session, regardless of directory
- `<leader>sd` — stop saving the current session (e.g. before a throwaway session)
