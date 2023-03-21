return {
  'nvim-lualine/lualine.nvim',
  opts = {
    options = {
      icons_enabled = true,
      theme = 'auto',
      component_separators = { left = '', right = ''},
      section_separators = { left = '', right = ''},
      disabled_filetypes = {
        statusline = {},
        winbar = {},
      },
      ignore_focus = {},
      always_divide_middle = true,
      globalstatus = true,
      refresh = {
        statusline = 1000,
        tabline = 1000,
        winbar = 1000,
      }
    },
    sections = {
      lualine_a = {'mode'},
      lualine_b = {'branch', 'diff', 'diagnostics'},
      lualine_c = {'filename'},
      lualine_x = {
        function()
          require('nvim-treesitter.statusline').statusline(90)
        end,
        'encoding',
        'fileformat',
        'filetype',
      },
      lualine_y = {'progress'},
      lualine_z = {'location'}
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {'filename'},
      lualine_x = {'location'},
      lualine_y = {},
      lualine_z = {}
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {
      'nvim-tree',
      'toggleterm',
      'fzf',
    }
  },
  event = 'BufWinEnter',
  dependencies = {
    'projekt0n/github-nvim-theme',
  },
  config = function (_, opts)
    local colors = require('github-theme.colors')
    local lualine = require('github-theme.plugins.lualine')

    local c = colors.setup({ theme_style = 'dark_default' })
    opts.options.theme = lualine.build_lualine_theme(c)
    require('lualine').setup(opts)
  end
}