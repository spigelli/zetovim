local colors = {
  selected_tab = '#0d1117',
  background_tab = '#070B10',
  background = '#010409',
}

-- Should point to ../../../../../plugins/github-nvim-theme/lua/github-theme/palette/dark_default.lua
---@class gt.Highlights

return {
  {
    "akinsho/bufferline.nvim",
    --   event = "VeryLazy",
    keys = {{
        "<leader>bp",
        "<Cmd>BufferLineTogglePin<CR>",
        desc = "Toggle pin"
    }, {
        "<leader>bP",
        "<Cmd>BufferLineGroupClose ungrouped<CR>",
        desc = "Delete non-pinned buffers"
    }},
    lazy = false,
    priority = 100000,
    opts = function() 
        local hi = require('util.colors').theme()
        local c = hi.colors
        return {
            options = {
                -- Use tabs
                mode = "buffers",

                -- No tab numbers
                numbers = "none",

                -- Cool tabs
                separator_style = "slant",

                -- Smaller X icon
                buffer_close_icon = "󰖭",

                -- Always show
                always_show_bufferline = true,

                diagnostics = "nvim_lsp",
                -- diagnostics_indicator = function(_, _, diag)
                --     local icons = require("lazyvim.config").icons.diagnostics
                --     local ret = (diag.error and icons.Error .. diag.error .. " " or "") ..
                --                     (diag.warning and icons.Warn .. diag.warning or "")
                --     return vim.trim(ret)
                -- end,

                -- No filetype icons
                show_buffer_icons = false,

                hover = {
                    enabled = true,
                    delay = 200,
                    reveal = {"close"}
                },

                offsets = {{
                    filetype = "neo-tree",
                    text_align = "left",
                    -- Should be equal to fillchars.vert
                    separator = "│",
                    highlight = {
                        bg = c.border,
                        bold = false,
                    },
                    text = function()
                    end
                }}
            },
        }
    end,
    config = function(_, opts)
        vim.cmd('set mousemoveevent')
        require("bufferline").setup(opts)
    end
  }
}
