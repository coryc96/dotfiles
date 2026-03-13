return {
  {
    'nvim-mini/mini.nvim',
    version = '*',
    opts = {},
    config = function()
      require('mini.pairs').setup()
      require('mini.statusline').setup()
      require('mini.files').setup()
      require('mini.files').setup()
--      require('mini.completion').setup()
    end,
  },
}
