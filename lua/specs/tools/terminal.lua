return {
  {
    'akinsho/toggleterm.nvim',
    version="*",
    -- event = 'VeryLazy',
    -- dev = true,
    opts = {
      open_mapping = '<D-t>',
      shade_filetypes = { 'none' },
      direction = 'horizontal',
      autochdir = true,
      persist_mode = true,
      insert_mappings = false,
      start_in_insert = true,
      winbar = { enabled = false },
      highlights = {
        FloatBorder = { link = 'FloatBorder' },
        NormalFloat = { link = 'NormalFloat' },
      },
      float_opts = {
        border = {
          border = { '┌', '─', '┐', '│', '┘', '─', '└', '│' },
          lsp_icons = {
            Text = '',
            Method = '',
            Function = '',
            Constructor = '',
            Field = '',
            Variable = '',
            Class = '',
            Interface = '',
            Module = '',
            Property = '',
            Unit = '',
            Value = '',
            Enum = '',
            Keyword = '',
            Snippet = '',
            Color = '',
            File = '',
            Reference = '',
            Folder = '',
            EnumMember = '',
            Constant = '',
            Struct = '',
            Event = '',
            Operator = '',
            TypeParameter = '',
            Namespace = '?',
            Package = '?',
            String = '?',
            Number = '?',
            Boolean = '?',
            Array = '?',
            Object = '?',
            Key = '?',
            Null = '?',
          },
        },
        winblend = 3,
      },
      size = function(term)
        if term.direction == 'horizontal' then
          return 15
        elseif term.direction == 'vertical' then
          return math.floor(vim.o.columns * 0.4)
        end
      end,
    },
    config = true,
  },
}
