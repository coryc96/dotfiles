--> LazyVim Bootstrap
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Set Map Leader
vim.g.mapleader = "\\" -- Make sure to set `mapleader` before lazy so your mappings are correct

-- List of Plugins (needs the requires below as well)
plugins = {
{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },

{ "nvim-tree/nvim-web-devicons" },

{ 'echasnovski/mini.surround', version = false },
{ 'echasnovski/mini.pairs', version = false },
{ 'echasnovski/mini.files', version = false },
{ 'echasnovski/mini.pick', version = false },
{ 'echasnovski/mini.extra', version = false },
{ 'echasnovski/mini.completion', version = false }
--{ 'stevearc/oil.nvim' }
}

require("lazy").setup(plugins, opts) -- Bootstraps lazy.nvim itself

require("nvim-web-devicons").setup()

require("mini.surround").setup() -- Enables commands manipulation of surrounding characters ("sa", "sd", etc)
require("mini.pairs").setup() -- Enables auto-pair creation
require("mini.files").setup() -- Enables the mini.files explorer
require("mini.pick").setup() -- Enables fuzzy search (telescope-esque)
require("mini.extra").setup() -- Provides extra pickers for mini.pick
require("mini.completion").setup() -- Provides lsp completion
--require("oil").setup()

-- Add hybrid line numbers
vim.o.number = true
vim.o.relativenumber = true

-- Word highlighting modifiers
vim.o.cursorline = true -- Highlights entire line with cursor present
vim.o.ic = true -- Ignores case on searches
vim.o.hlsearch = false -- Unhighlights text after search is done (enter)

-- Sets mouse mode
vim.o.mouse = 'a'
vim.api.nvim_set_keymap(
  "", "<RightDrag>", "<LeftDrag>",
  { noremap }
)
vim.api.nvim_set_keymap(
  "", "<RightMouse>", "<LeftMouse>",
  { noremap }
)
vim.api.nvim_set_keymap(
  "", "<LeftMouse>", "<nop>",
  { noremap }
)


-- Sets full clipboard
vim.o.clipboard=unnamedplus

-- Uses spaces for shift
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.smarttab = true

-- Sets up autocomplete
vim.o.completeopt = 'longest,menuone,preview,noinsert'

-- Allows recursive file-finding
vim.opt.path:append '**'


-- Enable better autocomplete lists
vim.o.wildmenu = true
vim.o.wildmode = 'longest,list'

-- Better file compatibility
vim.o.nocompatible = true
vim.o.syntax = true
vim.o.noendofline = true


-- Makes pretty
vim.o.termguicolors = true
vim.cmd.colorscheme "catppuccin"

-- ## BINDINGS ## --
--
-- Enables TAB and SHIFT+TAB for autocomplete navigation
vim.api.nvim_set_keymap(
  "i", "<Tab>", "pumvisible() ? '<C-n>' : '<Tab>'",
  { noremap, expr = true }
)

vim.api.nvim_set_keymap(
  "i", "<S-Tab>", "pumvisible() ? '<C-p>' : '<Tab>'",
  { noremap, expr = true }
)
--
--

-- Open File Explorer
vim.api.nvim_set_keymap(
  "n", "<C-e>", ":lua MiniFiles.open()<CR>",
  { noremap }
)

--
-- Sets up fuzzy finder bindings
-- -- Fuzzy find files
vim.api.nvim_set_keymap(
  "n", "<Leader>f", ":Pick files<CR>",
  { noremap }
)
-- -- Fuzzy find buffers
vim.api.nvim_set_keymap(
  "n", "<Leader>b", ":Pick buffers<CR>",
  { noremap }
)
--
--

-- Yanks into system clipboard
vim.api.nvim_set_keymap(
  "v", "<C-y>", ":'<,'>w !wl-copy<CR><CR>",
  { noremap }
)

