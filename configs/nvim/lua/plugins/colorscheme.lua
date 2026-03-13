return {
  {
    'thesimonho/kanagawa-paper.nvim',
    priority = 1000,
--    config = function()
--      if ACTIVE_THEME == 'kanagawa' then
--        vim.cmd.colorscheme 'kanagawa-paper-ink' 
--      end
--    end,
  },
  {
    'marko-cerovac/material.nvim',
    priority = 1000,
--    config = function()
--      vim.g.material_style = "deep ocean"
--      if ACTIVE_THEME == "material" then
--        vim.cmd.colorscheme("material")
--      end
--    end,
  },
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    opts = { flavour = "mocha" },
--    config = function(_, opts)
--      require("catppuccin").setup(opts)
--      if ACTIVE_THEME == "catppuccin" then
--        vim.cmd.colorscheme("catppuccin")
--      end
--    end,
  },
  {
  'f4z3r/gruvbox-material.nvim',
  name = 'gruvbox-material',
--  config = function(_, opts)
--    require("gruvbox-material").setup(opts)
--    if ACTIVE_THEME == "gruvbox-material" then
--      vim.cmd.colorscheme("gruvbox-material")
--    end
--  end,
  },
}
