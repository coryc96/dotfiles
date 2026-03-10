return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    bigfile = { enabled = true },
    quickfile = { enabled = true },
    dashboard = { enabled = true },
    explorer = { enabled = true },
    picker = { enabled = true },
    -- Enable the indent guides
    indent = {
      enabled = true,
      priority = 1,
      char = '│',
      only_scope = false, -- set to true to only show guides for the current scope
      only_current = false, -- set to true to only show in the current window

      -- Animation settings (requires Neovim >= 0.10)
      animate = {
        enabled = vim.fn.has 'nvim-0.10' == 1,
        style = 'out',
        duration = {
          step = 5,
          total = 500,
        },
      },
    },
    notifier = {
      enabled = true,
      timeout = 3000,
    },
    lsp = {
    auto_configure = true, -- Automatically setup LSP progress notifications
  },
  },
  styles = {
    notification = {
      wo = { wrap = true }, -- Wrap long notification lines
    },
  },
  -- You can enable other snacks here as you grow your config

  keys = {
    -- Inside lua/plugins/snacks.lua under keys = { ... }
    { "<leader>sk", function() Snacks.picker.keymaps() end, desc = "Keymaps (Search)" },
    { '<leader><leader>', function() Snacks.picker.buffers() end, desc = 'Buffers' },
    { '<leader>sf', function() Snacks.picker.files() end, desc = 'Find Files' },
    { '<leader>sg', function() Snacks.picker.grep() end, desc = 'Grep (Live)' },
    { '<leader>sb', function() Snacks.picker.lines() end, desc = 'Search in Buffer' },
    { '<leader>sh', function() Snacks.picker.help() end, desc = 'Help Tags' },
    { '<leader>sk', function() Snacks.picker.keymaps() end, desc = 'Keymaps' },
    { '<leader>sr', function() Snacks.picker.recent() end, desc = 'Recent Files' },
    { '<leader>sw', function() Snacks.picker.grep_word() end, desc = 'Visual selection or word', mode = { 'n', 'x' } },

    -- LSP related pickers
    { 'gd', function() Snacks.picker.lsp_definitions() end, desc = 'Goto Definition' },
    { 'gr', function() Snacks.picker.lsp_references() end, nowait = true, desc = 'References' },
    { 'gI', function() Snacks.picker.lsp_implementations() end, desc = 'Goto Implementation' },
    { 'gy', function() Snacks.picker.lsp_type_definitions() end, desc = 'Goto T[y]pe Definition' },
    { '<leader>ss', function() Snacks.picker.lsp_symbols() end, desc = 'LSP Symbols' },

    -- Git
    { '<leader>gl', function() Snacks.picker.git_log() end, desc = 'Git Log' },
    { '<leader>gs', function() Snacks.picker.git_status() end, desc = 'Git Status' },

    -- Terminal and Navigation
    { '<leader>cT', function() Snacks.terminal() end, desc = 'Terminal' },
    { '<leader>e', function() Snacks.explorer() end, desc = 'File Explorer' },
  },
}
