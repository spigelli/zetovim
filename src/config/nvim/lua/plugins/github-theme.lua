-- LazyVim Spec for projekt0n/github-nvim-theme
return {
  -- Initialize the theme
  {
    "projekt0n/github-nvim-theme",
    tag = "v0.0.7",
    ---@param opts github_theme.config.schema
    opts = function(_, opts)
      local github_theme = require("github-theme")
      return {
        colors = {},
        comment_style = "italic",
        dark_float = true,
        dark_sidebar = true,
        dev = false,
        function_style = "NONE",
        hide_end_of_buffer = true,
        hide_inactive_statusline = true,
        keyword_style = "italic",
        msg_area_style = "italic",
        sidebars = {},
        transparent = true,
        variable_style = "NONE",
        theme_style = "dark_default",
      }
    end,
    name = "github-theme",
  },
  init = function()
    -- Set the NormalFloat guibg
    vim.cmd("hi NormalFloat guibg=#161b22")
  end,
  -- Configure LazyVim to load github-theme
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "github_dark_default",
    },
  },
}
