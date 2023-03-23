return {
  'mrjones2014/winbarbar.nvim',
  opts = {
    -- Enable/disable auto-hiding the tab bar when there is a single buffer
    auto_hide = false,
    -- Enable/disable current/total tabpages indicator (top right corner)
    tabpages = true,
    -- Excludes buffers from the tabline
    -- exclude_ft = {'javascript'},
    -- exclude_name = {'package.json'},
    -- Enable/disable icons
    -- if set to 'numbers', will show buffer index in the tabline
    -- if set to 'both', will show buffer index and icons in the tabline
    icons = false,
    -- If set, the icon color will follow its corresponding buffer
    -- highlight group. By default, the Buffer*Icon group is linked to the
    -- Buffer* group (see Highlighting below). Otherwise, it will take its
    -- default value as defined by devicons.
    icon_custom_colors = false,
    -- Configure icons on the bufferline.
    icon_separator_active = '│',
    icon_separator_inactive = '|',
    icon_modified = '●',
    icon_pinned = '',
    -- If true, new buffers will be inserted at the start/end of the list.
    -- Default is to insert after current buffer.
    insert_at_end = true,
    insert_at_start = false,
    -- Sets the maximum padding width with which to surround each tab
    maximum_padding = 1,
    -- Sets the minimum padding width with which to surround each tab
    minimum_padding = 1,
    -- Sets the maximum buffer name length.
    maximum_length = 30,
    -- If set, the letters for each buffer in buffer-pick mode will be
    -- assigned based on their name. Otherwise or in case all letters are
    -- already assigned, the behavior is to assign letters in order of
    -- usability (see order below)
    semantic_letters = true,
    -- New buffer letters are assigned in this order. This order is
    -- optimal for the qwerty keyboard layout but might need adjustment
    -- for other layouts.
    letters = 'asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP',
    -- Sets the name of unnamed buffers. By default format is "[Buffer X]"
    -- where X is the buffer number. But only a static string is accepted here.
    no_name_title = nil,
    -- disable winbar on certain filetypes
    disabled_filetypes = {
      'neo-tree',
      'toggleterm',
      'Trouble',
    },
    -- disable winbar on certain buftypes
    disabled_buftypes = {},
  },
  config = function(_, opts)
    require('bufferline').setup(opts)
  end,
}