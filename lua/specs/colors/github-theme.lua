return {
  "projekt0n/github-nvim-theme",
  dev = true,
  lazy=false,
  priority=1000,
  opts = {
      colors={},
      comment_style="italic",
      dark_float = true,
      dark_sidebar = true,
      function_style = "italic",
      hide_end_of_buffer = true,
      hide_inactive_statusline = false,
      keyword_style = "italic",
      sidebars = {
        "qf",
        "vista_kind",
        "terminal",
        "packer",
        "neo-tree",
      },
      theme_style = "dark_default",
      transparent = false,
  },
  init = function()
  end,
  config = function(_, opts)
      require("github-theme").setup(opts)
  end,
}
