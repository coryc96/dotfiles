return {
  'akinsho/bufferline.nvim',
  version = '*',
  dependencies = 'nvim-tree/nvim-web-devicons',
  event = 'VeryLazy',
  keys = {
    { '<S-h>', '<cmd>BufferLineCyclePrev<cr>', desc = 'Prev Buffer' },
    { '<S-l>', '<cmd>BufferLineCycleNext<cr>', desc = 'Next Buffer' },
    { '[b', '<cmd>BufferLineCyclePrev<cr>', desc = 'Prev Buffer' },
    { ']b', '<cmd>BufferLineCycleNext<cr>', desc = 'Next Buffer' },
    { '<leader>bp', '<cmd>BufferLinePick<cr>', desc = 'Buffer Pick' },
    { '<leader>bc', '<cmd>BufferLinePickClose<cr>', desc = 'Buffer Pick Close' },
  },
  opts = {
    options = {
      mode = 'buffers',
      separator_style = 'slope', -- can be "slant" | "slope" | "thick" | "thin"
      diagnostics = 'nvim_lsp',
      always_show_bufferline = false,
      show_buffer_close_icons = false,
      show_close_icon = false,
      --offsets = {
      --  {
      --    filetype = 'snacks_layout_explorer',
      --    text = 'File Explorer',
      --    text_align = 'left',
      --    separator = true,
      --  },
      --},
    },
  },
}
