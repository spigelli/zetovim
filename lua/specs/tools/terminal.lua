return {
  {
    'akinsho/toggleterm.nvim',
    version="*",
    -- event = 'VeryLazy',
    -- dev = true,
    opts = {
      open_mapping = '<D-t>',
      on_open = function(term)
        pcall(function()
          require('virt-column').setup_buffer({
            virtcolumn = '',
          })
        end)
      end,
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
    config = function(_, opts)
      require('toggleterm').setup(opts)
      local Terminal  = require('toggleterm.terminal').Terminal
      local lazygit = Terminal:new({
        cmd = "lazygit",
        dir = "git_dir",
        direction = "float",
        float_opts = {
          border = "double",
        },
        -- function to run on opening the terminal
        on_open = function(term)
          vim.cmd("startinsert!")
          vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
        end,
        -- function to run on closing the terminal
        on_close = function(term)
          vim.cmd("startinsert!")
        end,
      })

      function _lazygit_toggle()
        lazygit:toggle()
      end

      vim.api.nvim_set_keymap("n", "<Space>g", "<cmd>lua _lazygit_toggle()<CR>", {noremap = true, silent = true})
    end,
  },
}

