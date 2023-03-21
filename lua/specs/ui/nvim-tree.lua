return {
  {
    "nvim-tree/nvim-tree.lua",
    cmd = {"NvimTreeToggle", "NvimTreeFocus"},
    -- init = require("core.utils").load_mappings "nvimtree",
    dependencies = {
        "kyazdani42/nvim-web-devicons"
    },
    opts = function()
      return {
        filters = {
            dotfiles = false,
            exclude = {vim.fn.stdpath "config" .. "/lua/custom"}
        },
        disable_netrw = true,
        hijack_netrw = true,
        hijack_cursor = true,
        hijack_unnamed_buffer_when_opening = false,
        sync_root_with_cwd = true,
        update_focused_file = {
            enable = true,
            update_root = false
        },
        view = {
            adaptive_size = true,
            side = "left",
            width = 30,
            hide_root_folder = false
        },
        git = {
            enable = true,
            ignore = false
        },
        filesystem_watchers = {
            enable = true
        },
        tab = {
          sync = {
            open = true,
            close = true,
          },
        },
        actions = {
            use_system_clipboard = true,
            change_dir = {
            enable = true,
            global = false,
            restrict_above_cwd = false,
            },
            expand_all = {
            max_folder_discovery = 300,
            exclude = {},
            },
            file_popup = {
            open_win_config = {
                col = 1,
                row = 1,
                relative = "cursor",
                border = "shadow",
                style = "minimal",
            },
            },
            open_file = {
            quit_on_open = false,
            resize_window = true,
            window_picker = {
                enable = true,
                picker = "default",
                chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
                exclude = {
                filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
                buftype = { "nofile", "terminal", "help" },
                },
            },
            },
            remove_file = {
                close_window = true,
            },
        },
        renderer = {
            root_folder_label = function (path)
                local path_from_home = vim.fn.fnamemodify(path, ":~:s?$?/..?")
                -- split path into directories
                local path_split = vim.split(path_from_home, "/")
                -- get last 2 directories
                local path_split_length = vim.fn.len(path_split)
                if path_split_length <= 2 then
                    return "  ".. path_from_home
                end
                local path_last_2_dirs = path_split[path_split_length - 2] .. "/" .. path_split[path_split_length - 1]
                return "  ".. path_last_2_dirs
            end,
            highlight_git = true,
            highlight_opened_files = "none",
            indent_width = 1,
            indent_markers = {
                enable = true,
                inline_arrows = true,
                icons = {
                    corner = "│",
                    edge = '│',
                    item = '│',
                    bottom = '',
                    none = '',
                },
            },
            icons = {
                webdev_colors = true,
                git_placement = "before",
                modified_placement = "after",
                padding = "  ",
                symlink_arrow = " ➛ ",
                show = {
                    file = true,
                    folder = true,
                    folder_arrow = false,
                    git = false
                },
                glyphs = {
                    default = "",
                    symlink = "",
                    folder = {
                        default = "",
                        empty = "",
                        empty_open = "",
                        open = "",
                        symlink = "",
                        symlink_open = "",
                        arrow_open = "",
                        arrow_closed = ""
                    },
                    git = {
                        unstaged = "✗",
                        staged = "✓",
                        unmerged = "",
                        renamed = "➜",
                        untracked = "★",
                        deleted = "",
                        ignored = "◌"
                    }
                }
            }
        },
        diagnostics = {
            enable = true,
            show_on_dirs = true,
            show_on_open_dirs = true,
            debounce_delay = 50,
            severity = {
                min = vim.diagnostic.severity.WARNING,
                max = vim.diagnostic.severity.ERROR,
            },
            icons = {
                hint = "",
                info = "",
                warning = "",
                error = "",
            },
        },
      }
    end,
    config = function(_, opts)
        require("nvim-tree").setup(opts)
        local tree_api = require("nvim-tree.api")
        local function opts(desc)
            return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end
        vim.keymap.set(
            "n",
            "<LeftRelease>",
            tree_api.node.open.preview,
            opts('Open Preview')
        )
        --[[
            NvimTreeOpenedFile
            NvimTreeOpenedFolderName
            NvimTreeFolderName
            NvimTreeSymlink
            NvimTreeImageFile
            NvimTreeIndentMarker - #21262d
            NvimTreeSpecialFile
            NvimTreeGitIgnored
            NvimTreeGitDeleted
            NvimTreeFolderIcon - #8b949e
            NvimTreeNormal - bg: #010409
            NvimTreeModifiedFile - #d29922
        --]]
        -- vim.api.nvim_set_hl(
        --     0,
        --     'NvimTreeIndentMarker',
        --     { fg = '#21262d', bold = false }
        -- )
        local highlights = {
            -- NvimTreeIndentMarker = { fg = '#21262d', bold = false },
            NvimTreeIndentMarker = { fg = '#FF262d', bold = false },
            NvimTreeFolderName = { fg = "#fcfcfc" },
            NvimTreeRootFolder = { fg = "#fcfcfc", bold = true },
            NvimTreeFolderIcon = { fg = '#8b949e', bold = false },
            NvimTreeNormal = { fg = "#fcfcfc", bg = '#010409' },
            NvimTreeModifiedFile = { fg = '#d29922' },
            NvimTreeOpenedFile = { fg = '#1f6feb' },
            NvimTreeGitDirty = { fg = '#d29922' },
            NvimTreeGitDeleted = { fg = '#d29922', bold = true },
            NvimTreeDiagnosticError = { fg = '#ffa198' },
            NvimTreeDiagnosticsWarning = { fg = '#cca710' },
            NvimTreeCursorLine = { bg = '#2d3139' },
            NvimTreeWinSeparator = { fg = '#30363d' },
        }
        -- For each highlight, set the highlight
        vim.api.nvim_set_hl(0, 'NvimTreeIndentMarker', { fg = '#21262d', bold = false })
        vim.api.nvim_set_hl(0, 'NvimTreeFolderName', { fg = "#fcfcfc" })
        vim.api.nvim_set_hl(0, 'NvimTreeOpenedFolderName', { fg = "#fcfcfc" })
        vim.api.nvim_set_hl(0, 'NvimTreeRootFolder', { fg = "#fcfcfc" })
        vim.api.nvim_set_hl(0, 'NvimTreeFolderIcon', { fg = '#8b949e', bold = false })
        vim.api.nvim_set_hl(0, 'NvimTreeNormal', { fg = "#fcfcfc", bg = '#010409' })
        vim.api.nvim_set_hl(0, 'NvimTreeModifiedFile', { fg = '#d29922', bold = true })
        vim.api.nvim_set_hl(0, 'NvimTreeOpenedFile', { fg = '#1f6feb' })
        vim.api.nvim_set_hl(0, 'NvimTreeGitDirty', { fg = '#d29922', bold = true })
        vim.api.nvim_set_hl(0, 'NvimTreeGitDeleted', { fg = '#d29922' })
        vim.api.nvim_set_hl(0, 'NvimTreeDiagnosticError', { fg = '#ffa198' })
        vim.api.nvim_set_hl(0, 'NvimTreeDiagnosticsWarning', { fg = '#cca710' })
        vim.api.nvim_set_hl(0, 'NvimTreeCursorLine', { bg = '#2d3139' })
        vim.api.nvim_set_hl(0, 'NvimTreeWinSeparator', { fg = '#30363d' })
    end
  }
}
