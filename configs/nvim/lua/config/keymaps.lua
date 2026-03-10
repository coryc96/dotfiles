-- lua/config/keymaps.lua

local map = vim.keymap.set

-- General
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
-- Yank into system clipboard
vim.keymap.set('v', '<leader>y', [["+y]], { desc = 'Yank to system clipboard' })

-- LSP
vim.keymap.set('n', '<leader>ff', vim.lsp.buf.format, { desc = '[F]ormat buffer' })

-- Diagnostic Jump Logic
local diagnostic_goto = function(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function() go { severity = severity } end
end

-- General Diagnostics
map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
map('n', ']d', diagnostic_goto(true), { desc = 'Next Diagnostic' })
map('n', '[d', diagnostic_goto(false), { desc = 'Prev Diagnostic' })
-- Errors
map('n', ']e', diagnostic_goto(true, 'ERROR'), { desc = 'Next Error' })
map('n', '[e', diagnostic_goto(false, 'ERROR'), { desc = 'Prev Error' })
-- Warnings
map('n', ']w', diagnostic_goto(true, 'WARN'), { desc = 'Next Warning' })
map('n', '[w', diagnostic_goto(false, 'WARN'), { desc = 'Prev Warning' })

-- Terminal Mode Fixes
map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
map('t', '<C-h>', '<C-\\><C-n><C-w>h', { desc = 'Go to left window' })
map('t', '<C-j>', '<C-\\><C-n><C-w>j', { desc = 'Go to lower window' })
map('t', '<C-k>', '<C-\\><C-n><C-w>k', { desc = 'Go to upper window' })
map('t', '<C-l>', '<C-\\><C-n><C-w>l', { desc = 'Go to right window' })

-- Modern Window Management
map('n', '<C-h>', '<C-w>h', { desc = 'Go to Left Window', remap = true })
map('n', '<C-j>', '<C-w>j', { desc = 'Go to Lower Window', remap = true })
map('n', '<C-k>', '<C-w>k', { desc = 'Go to Upper Window', remap = true })
map('n', '<C-l>', '<C-w>l', { desc = 'Go to Right Window', remap = true })

-- Resize window using <ctrl> arrow keys
map('n', '<C-Up>', '<cmd>resize +2<cr>', { desc = 'Increase Window Height' })
map('n', '<C-Down>', '<cmd>resize -2<cr>', { desc = 'Decrease Window Height' })
map('n', '<C-Left>', '<cmd>vertical resize -2<cr>', { desc = 'Decrease Window Width' })
map('n', '<C-Right>', '<cmd>vertical resize +2<cr>', { desc = 'Increase Window Width' })
