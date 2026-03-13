-- lua/plugins/lsp.lua
local servers = { "lua_ls", "rust_analyzer"}
return {
{
  "neovim/nvim-lspconfig", -- Now primarily a data repo for vim.lsp.config
  dependencies = {
    { "williamboman/mason.nvim", opts = {} },
    {
      "williamboman/mason-lspconfig.nvim",
      opts = {
        -- LIST ONCE HERE: Mason will install them, and 
        -- mason-lspconfig v2+ will automatically call vim.lsp.enable()
        ensure_installed = servers
      },
    },
  },
  config = function()
    -- 2. Global LSP Defaults (New in 0.11)
    -- This replaces the old "on_attach" and "capabilities" boilerplate
    vim.lsp.config("*", {
      root_markers = { ".git" },
      capabilities = vim.lsp.protocol.make_client_capabilities(),
    })

    -- Optional: Keymaps for when an LSP attaches
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local opts = { buffer = args.buf }
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, {desc = "Go to Definition"})
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
      end,
    })
    vim.lsp.enable(servers)
  end,
  },
}
