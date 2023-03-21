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
        local background_fill = c.bg3
        local background_tab = c.bg2
        local background_selected_tab = c.bg
        return {
            options = {
                -- Use tabs
                mode = "buffers",

                -- No tab numbers
                numbers = "none",

                -- Cool tabs
                separator_style = "slant",

                -- Smaller X icon
                buffer_close_icon = "󰅖",

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
                        bg = c.bg2,
                        bold = false,
                    },
                    text = function()
                    end
                }}
            },
            -- highlights = {
            --     fill = {
            --         bg = background_fill,
            --     },
            --     background = {
            --         bg = background_fill,
            --     },
            --     buffer_visible = { -- the selected buffer when in file viewer
            --         bg = background_selected_tab,
            --         fg = '#c9d1d9',
            --         bold = false,
            --         italic = false,
            --     },
            --     buffer_selected = {
            --         bg = background_selected_tab,
            --         fg = '#c9d1d9',
            --         bold = true,
            --         italic = false,
            --     },
            --     separator_selected = {
            --         fg = background_fill,
            --         bg = background_selected_tab,
            --     },
            --     separator_visible = {
            --         fg = background_fill,
            --         bg = background_selected_tab,
            --     },
            --     separator = {
            --         fg = background_fill,
            --         bg = background_selected_tab,
            --     },
            --     offset_separator = {
            --         fg = c.border,
            --         bg = background_fill,
            --     },
            --     -- tab = {
            --     --     fg = '#ff0000',
            --     --     bg = '#00ff00',
            --     -- },
            --     -- tab_selected = {
            --     --     fg = '#00AFF0',
            --     --     bg = '#Fd11F7',
            --     -- },
            -- },
        }
    end,
    config = function(_, opts)
        vim.cmd('set mousemoveevent')
        require("bufferline").setup(opts)
        -- For some reason, this is necessary to get the
        -- background color to be set correctly
        local hi = require('util.colors').theme()
        local c = hi.colors
        vim.defer_fn(
            function()
                vim.api.nvim_set_hl(
                    0,
                    'BufferLineBackground',
                    {
                        bg = c.bg3,
                        -- fg = '#8b949e',
                        bold = false,
                        italic = false,
                    }
                )
            end,
            100
        )
    end
  }
}
