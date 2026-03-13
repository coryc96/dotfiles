-- lua/plugins/godot.lua
-- Function to find Godot project root directory
local function find_godot_project_root()
    local cwd = vim.fn.getcwd()
    local search_paths = { '', '/..' }
    
    for _, relative_path in ipairs(search_paths) do
        local project_file = cwd .. relative_path .. '/project.godot'
        if vim.uv.fs_stat(project_file) then
            return cwd .. relative_path
        end
    end
    
    return nil
end

-- Function to check if server is already running
local function is_server_running(project_path)
    local server_pipe = project_path .. '/server.pipe'
    return vim.uv.fs_stat(server_pipe) ~= nil
end

-- Function to start Godot server if needed
local function start_godot_server_if_needed()
    local godot_project_path = find_godot_project_root()
    
    if godot_project_path and not is_server_running(godot_project_path) then
        vim.fn.serverstart(godot_project_path .. '/server.pipe')
        return true
    end
    
    return false
end

-- Main execution
start_godot_server_if_needed()
return {
  -- 1. Main Anchor: Syntax highlighting and LSP logic
  {
    "habamax/vim-godot",
    ft = { "gdscript", "gdscript3" },
    dependencies = { "skywind3000/asyncrun.vim" },
    config = function()

      -- Define the config using the new 0.11 API
      vim.lsp.config("gdscript", {
        cmd = vim.lsp.rpc.connect("127.0.0.1", tonumber(6005)),
        filetypes = { "gd", "gdscript", "gdscript3" },
        root_markers = { "project.godot", ".git" },
      })

      -- Enable it for the current session
      vim.lsp.enable("gdscript")

      -- Native 0.11 completion integration
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client and client.name == "gdscript" then
            -- Use the new 0.11 native completion UI if available
            if vim.lsp.completion then
              vim.lsp.completion.enable(true, client.id)
            end
          end
        end,
      })
    end,
  },

  -- 2. Documentation Support
  {
    "teatek/gdscript-extended-lsp.nvim",
    ft = { "gdscript", "gdscript3" },
    opts = {
      view_type = "vsplit",
      picker = "snacks", -- Uses Snacks.picker (part of LazyVim)
    },
    keys = {
      -- Open the documentation search picker
      { "<leader>gD", function() require("gdscript-extended-lsp").pick() end, desc = "Search Godot Docs" },
    },
  },

  -- 3. Cleanup UI (Snacks.nvim)
  {
    "folke/snacks.nvim",
    optional = true,
    opts = {
      picker = {
        sources = {
          explorer = {
            -- Keeps your file tree clean of Godot metadata
            exclude = { "*.uid", "server.pipe", ".godot" },
          },
        },
      },
    },
  },
}
