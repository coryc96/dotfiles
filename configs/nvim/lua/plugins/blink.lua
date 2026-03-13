return {
  "saghen/blink.cmp",
  enabled = true,
  version = "1.*",
  opts = function(_, opts)
    opts.enabled = function()
      local filetype = vim.bo[0].filetype
      if filetype == "minifiles" or filetype == "snacks_picker_input" then
        return false
      end
      return true
    end

    return opts
  end,
}
