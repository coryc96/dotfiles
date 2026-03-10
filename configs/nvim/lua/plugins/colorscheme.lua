--return {
--
--  'embark-theme/vim',
--  lazy = false,
--  priority = 1000,
--  name = 'embark',
--  config = function() vim.cmd.colorscheme 'embark' end,
--}
return {
  'thesimonho/kanagawa-paper.nvim',
  lazy = false,
  priority = 1000,
  init = function() vim.cmd.colorscheme 'kanagawa-paper-ink' end,
  opts = { ... },
}
