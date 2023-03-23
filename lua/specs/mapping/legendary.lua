-- This plugin is actually loaded as a dependency to
-- which key
-- local mappings = require("config.mappings")

return {
  "mrjones2014/legendary.nvim",
  tag = "v2.1.0",
  event = "VimEnter",
  dependencies = {
    { import = "specs.ui.dressing" },
  },
  opts = {
    keymaps = {
      { '<D-e>', ':ToggleFileBrowser<CR>',  description = 'Toggle File Browser'   },
      { '<D-w>', ':bd<CR>',                 description = 'Close Active Buffer'   },
      { '<D-P>', ':Legendary<CR>',          description = 'Toggle Legendary'      },
      { '<D-K>', ':Legendary<CR>',          description = 'Toggle Legendary'      },
      -- { '<D-{>', ':BufferPrevious<CR>',     description = 'Cycle Previous Buffer' },
      -- { '<D-}>', ':BufferNext<CR>',         description = 'Cycle Next Buffer'     },
      { '<D-[>', ':BufferMovePrevious<CR>', description = 'Move Buffer Left'      },
      { '<D-]>', ':BufferMoveNext<CR>',     description = 'Move Buffer Right'     },
      { '<C-h>', ':wincmd h<CR>',           description = 'Move to Left Window',   mode = { 'n', 't' } },
      { '<C-j>', ':wincmd j<CR>',           description = 'Move to Bottom Window', mode = { 'n', 't' } },
      { '<C-k>', ':wincmd k<CR>',           description = 'Move to Top Window',    mode = { 'n', 't' } },
      { '<C-l>', ':wincmd l<CR>',           description = 'Move to Right Window',  mode = { 'n', 't' } },
      { 'gh',    function() vim.lsp.buf.hover() end, description = 'Hover' },
      { '<space><space>tch', ':Telescope highlights<CR>', description = 'Telescope Highlights' },
      { '<space><space>nih', ':Inspect<CR>',              description = 'Telescope Highlights' },
      { '<space><space>nit', ':InspectTree<CR>',          description = 'Telescope Highlights' },
    },
    commands = {
      {
        ':ToggleFileBrowser',
        require('config.commands').toggle_neo_tree,
        description = [[
          Toggle the file browser or focus it if it is
          already open and in another window
        ]],
      },
      {
        ':CloseBuffer',
        require('config.commands').close_buffer,
        description = [[
          Close the current buffer
        ]],
      },
    },
    augroups = {
      {
        'NumberToggle',
        clear=true,
        {
          function()
            if vim.o.nu and vim.api.nvim_get_mode().mode ~= "i" then
              vim.opt.relativenumber = true
            end
          end,
          { "BufEnter", "FocusGained", "InsertLeave", "CmdlineLeave", "WinEnter" },
          description="Turn on relative numbers when entering a buffer",
          opts = {
            pattern="*"
          },
        },
        {
          function()
            if vim.o.nu then
              vim.opt.relativenumber = false
              vim.cmd "redraw"
            end
          end,
          { "BufLeave", "FocusLost", "InsertEnter", "CmdlineEnter", "WinLeave" },
          description="Turn off relative numbers when leaving a buffer",
          opts = {
            pattern="*"
          },
        },
      },
    }
  },
}