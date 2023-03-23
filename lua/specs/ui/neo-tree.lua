-- system_open = function(state) require("astronvim.utils").system_open(state.tree:get_node():get_id()) end,
local function parent_or_close(state)
  local node = state.tree:get_node()
  if (node.type == "directory" or node:has_children()) and node:is_expanded() then
    state.commands.toggle_node(state)
  else
    require("neo-tree.ui.renderer").focus_node(state, node:get_parent_id())
  end
end

local function child_or_open(state)
  local node = state.tree:get_node()
  if node.type == "directory" or node:has_children() then
    if not node:is_expanded() then -- if unexpanded, expand
      state.commands.toggle_node(state)
    else -- if expanded and has children, seleect the next child
      require("neo-tree.ui.renderer").focus_node(state, node:get_child_ids()[1])
    end
  else -- if not a directory just open it
    state.commands.open(state)
  end
end

local function copy_selector(state)
  local node = state.tree:get_node()
  local filepath = node:get_id()
  local filename = node.name
  local modify = vim.fn.fnamemodify
  local results = {
    e = { val = modify(filename, ":e"), msg = "Extension only" },
    f = { val = filename, msg = "Filename" },
    F = { val = modify(filename, ":r"), msg = "Filename w/o extension" },
    h = { val = modify(filepath, ":~"), msg = "Path relative to Home" },
    p = { val = modify(filepath, ":."), msg = "Path relative to CWD" },
    P = { val = filepath, msg = "Absolute path" },
  }
  local messages = {
    { "\nChoose to copy to clipboard:\n", "Normal" },
  }
  for i, result in pairs(results) do
    if result.val and result.val ~= "" then
      vim.list_extend(messages, {
        { ("%s."):format(i), "Identifier" },
        { (" %s: "):format(result.msg) },
        { result.val, "String" },
        { "\n" },
      })
    end
  end
  vim.api.nvim_echo(messages, false, {})
  local result = results[vim.fn.getcharstr()]
  if result and result.val and result.val ~= "" then
    vim.notify("Copied: " .. result.val)
    vim.fn.setreg("+", result.val)
  end
end

return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = "v2.x",
  cond = function()
    return false
  end,
  lazy = true,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  opts = function()
    return {
      -- If a user has a sources list it will replace this one.
      -- Only sources listed here will be loaded.
      -- You can also add an external source by adding it's name to this list.
      -- The name used here must be the same name you would use in a require() call.
      sources = { -- *
        "filesystem",
        -- "buffers",
        -- "git_status",
      },
      add_blank_line_at_top = false, -- Add a blank line at the top of the tree.
      auto_clean_after_session_restore = false, -- Automatically clean up broken neo-tree buffers saved in sessions
      close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
      -- popup_border_style is for input and confirmation dialogs.
      -- Configurtaion of floating window is done in the individual source sections.
      -- "NC" is a special style that works well with NormalNC set
      close_floats_on_escape_key = true,
      default_source = "filesystem",
      enable_diagnostics = true,
      enable_git_status = true,
      enable_modified_markers = true, -- Show markers for files with unsaved changes.
      enable_refresh_on_write = true, -- Refresh the tree when a file is written. Only used if `use_libuv_file_watcher` is false.
      git_status_async = true,
      -- These options are for people with VERY large git repos
      git_status_async_options = {
        batch_size = 1000, -- how many lines of git status results to process at a time
        batch_delay = 10,  -- delay in ms between batches. Spreads out the workload to let other processes run.
        max_lines = 10000, -- How many lines of git status results to process. Anything after this will be dropped.
        -- Anything before this will be used. The last items to be processed are the untracked files.
      },
      hide_root_node = false, -- Hide the root node.
      retain_hidden_root_indent = false, -- IF the root node is hidden, keep the indentation anyhow.
      -- This is needed if you use expanders because they render in the indent.
      log_level = "info", -- "trace", "debug", "info", "warn", "error", "fatal"
      log_to_file = false, -- true, false, "/path/to/file.log", use :NeoTreeLogs to show the file
      open_files_in_last_window = true, -- false = open files in top left window
      open_files_do_not_replace_types = { "terminal", "trouble", "qf" }, -- when opening files, do not use windows containing these filetypes or buftypes
      popup_border_style = "rounded", -- "double", "none", "rounded", "shadow", "single" or "solid" *
      resize_timer_interval = 500, -- in ms, needed for containers to redraw right aligned and faded content
      sort_case_insensitive = false, -- used when sorting files and directories in the tree
      sort_function = nil , -- uses a custom function for sorting files and directories in the tree
      use_popups_for_input = true, -- If false, inputs will use vim.ui.input() instead of custom floats.
      use_default_mappings = true,
      default_component_configs = {
        container = {
          enable_character_fade = true,
          width = "100%",
          right_padding = 0,
        },
        indent = {
          indent_size = 2,
          padding = 1,
          -- indent guides
          with_markers = true,
          indent_marker = "│",
          last_indent_marker = "│", -- *
          highlight = "NeoTreeIndentMarker",
          -- expander config, needed for nesting files
          with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
          expander_collapsed = "",
          expander_expanded = "",
          expander_highlight = "NeoTreeExpander",
        },
        icon = {
          folder_closed = "",
          folder_open = "",
          folder_empty = "",
          folder_empty_open = "",
          -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
          -- then these will never be used.
          default = "*",
          highlight = "NeoTreeFileIcon"
        },
        modified = {
          symbol = "[+] ",
          highlight = "NeoTreeModified",
        },
        name = {
          trailing_slash = false,
          use_git_status_colors = true,
          highlight = "NeoTreeFileName",
        },
        git_status = {
          symbols = {
            -- Change type
            added     = "✚", -- NOTE: you can set any of these to an empty string to not show them
            deleted   = "✖",
            -- modified  = "",
            modified  = "M",
            renamed   = "",
            -- Status type
            untracked = "",
            -- ignored   = "",
            ignored   = "",
            unstaged  = "",
            staged    = "",
            conflict  = "",
          },
          align = "right",
        },
      },
      renderers = {
        directory = {
          { "indent" },
          { "icon" },
          { "current_filter" },
          {
            "container",
            content = {
              { "name", zindex = 10 },
              -- {
              --   "symlink_target",
              --   zindex = 10,
              --   highlight = "NeoTreeSymbolicLinkTarget",
              -- },
              { "clipboard", zindex = 10 },
              { "diagnostics", errors_only = true, zindex = 20, align = "right", hide_when_expanded = true },
              { "git_status", zindex = 20, align = "right", hide_when_expanded = true },
            },
          },
        },
        file = {
          { "indent" },
          { "icon" },
          {
            "container",
            content = {
              {
                "name",
                zindex = 10
              },
              -- {
              --   "symlink_target",
              --   zindex = 10,
              --   highlight = "NeoTreeSymbolicLinkTarget",
              -- },
              { "clipboard", zindex = 10 },
              { "bufnr", zindex = 10 },
              { "modified", zindex = 20, align = "right" },
              { "diagnostics",  zindex = 20, align = "right" },
              { "git_status", zindex = 20, align = "right" },
            },
          },
        },
        message = {
          { "indent", with_markers = false },
          { "name", highlight = "NeoTreeMessage" },
        },
        terminal = {
          { "indent" },
          { "icon" },
          { "name" },
          { "bufnr" }
        }
      },
      nesting_rules = {},
      window = { -- see https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/popup for
        -- possible options. These can also be functions that return these options.
        position = "left", -- left, right, top, bottom, float, current
        width = 40, -- applies to left and right positions
        height = 15, -- applies to top and bottom positions
        auto_expand_width = false, -- expand the window when file exceeds the window width. does not work with position = "float"
        popup = { -- settings that apply to float position only
          size = {
            height = "80%",
            width = "50%",
          },
          position = "50%", -- 50% means center it
        },
        same_level = false, -- Create and paste/move files/directories on the same level as the directory under cursor (as opposed to within the directory under cursor).
        insert_as = "child", -- Affects how nodes get inserted into the tree during creation/pasting/moving of files if the node under the cursor is a directory:
        mapping_options = {
          noremap = true,
          nowait = true,
        },
        mappings = {
          -- ["<space>"] = {
          --   "toggle_node",
          --   nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use
          -- },
          ["<2-LeftMouse>"] = child_or_open,
          ["<cr>"] = child_or_open,
          ["<esc>"] = "revert_preview",
          ["P"] = { "toggle_preview", config = { use_float = true } },
          ["<space>"] = { "toggle_preview", config = { use_float = true } },
          ["S"] = "open_split",
          -- ["S"] = "split_with_window_picker",
          ["s"] = "open_vsplit",
          -- ["s"] = "vsplit_with_window_picker",
          ["t"] = "open_tabnew",
          -- ["<cr>"] = "open_drop",
          -- ["t"] = "open_tab_drop",
          ["w"] = "open_with_window_picker",
          ["C"] = "close_node",
          ["z"] = "close_all_nodes",
          --["Z"] = "expand_all_nodes",
          ["R"] = "refresh",
          ["a"] = {
            "add",
            -- some commands may take optional config options, see `:h neo-tree-mappings` for details
            config = {
              show_path = "none", -- "none", "relative", "absolute"
            }
          },
          ["A"] = "add_directory", -- also accepts the config.show_path and config.insert_as options.
          ["d"] = "delete",
          ["r"] = "rename",
          ["y"] = "copy_to_clipboard",
          ["x"] = "cut_to_clipboard",
          ["p"] = "paste_from_clipboard",
          ["c"] = "copy", -- takes text input for destination, also accepts the config.show_path and config.insert_as options
          ["m"] = "move", -- takes text input for destination, also accepts the config.show_path and config.insert_as options
          ["e"] = "toggle_auto_expand_width",
          ["q"] = "close_window",
          ["?"] = "show_help",
          ["<"] = "prev_source",
          [">"] = "next_source",
          h = parent_or_close,
          l = child_or_open,
          Y = copy_selector,
        },
      },
      filesystem = {
        window = {
          mappings = {
            ["H"] = "toggle_hidden",
            ["/"] = "fuzzy_finder",
            ["D"] = "fuzzy_finder_directory",
            --["/"] = "filter_as_you_type", -- this was the default until v1.28
            ["#"] = "fuzzy_sorter", -- fuzzy sorting using the fzy algorithm
            -- ["D"] = "fuzzy_sorter_directory",
            ["f"] = "filter_on_submit",
            ["<C-x>"] = "clear_filter",
            ["<bs>"] = "navigate_up",
            ["."] = "set_root",
            ["[g"] = "prev_git_modified",
            ["]g"] = "next_git_modified",
          }
        },
        async_directory_scan = "auto", -- "auto"   means refreshes are async, but it's synchronous when called from the Neotree commands.
        scan_mode = "shallow", -- "shallow": Don't scan into directories to detect possible empty directory a priori
        bind_to_cwd = true, -- true creates a 2-way binding between vim's cwd and neo-tree's root
        cwd_target = {
          sidebar = "tab",   -- sidebar is when position = left or right
          current = "window" -- current is when position = current
        },
        filtered_items = {
          visible = true, -- when true, they will just be displayed differently than normal items *
          force_visible_in_empty_folder = false, -- when true, hidden files will be shown if the root folder is otherwise empty
          show_hidden_count = true, -- when true, the number of hidden items in each folder will be shown as the last entry
          hide_dotfiles = true,
          hide_gitignored = true,
          hide_hidden = true, -- only works on Windows for hidden files/directories
          hide_by_name = {
            ".DS_Store",
            "thumbs.db"
            --"node_modules",
          },
          hide_by_pattern = { -- uses glob style patterns
            --"*.meta",
            --"*/src/*/tsconfig.json"
          },
          always_show = { -- remains visible even if other settings would normally hide it
            --".gitignored",
          },
          never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
            --".DS_Store",
            --"thumbs.db"
          },
          never_show_by_pattern = { -- uses glob style patterns
            --".null-ls_*",
          },
        },
        find_by_full_path_words = false,  -- `false` means it only searches the tail of a path.
        group_empty_dirs = false, -- when true, empty folders will be grouped together
        search_limit = 50, -- max number of search results when using filters
        follow_current_file = false, -- This will find and focus the file in the active buffer every time
        -- the current file is changed while the tree is open.
        hijack_netrw_behavior = "open_default", -- netrw disabled, opening a directory opens neo-tree
        use_libuv_file_watcher = false, -- This will use the OS level file watchers to detect changes
        -- instead of relying on nvim autocmd events.
      },
      buffers = {
        bind_to_cwd = true,
        follow_current_file = true, -- This will find and focus the file in the active buffer every time
        -- the current file is changed while the tree is open.
        group_empty_dirs = true, -- when true, empty directories will be grouped together
        window = {
          mappings = {
            ["<bs>"] = "navigate_up",
            ["."] = "set_root",
            ["bd"] = "buffer_delete",
          },
        },
      },
      git_status = {
        window = {
          mappings = {
            ["A"] = "git_add_all",
            ["gu"] = "git_unstage_file",
            ["ga"] = "git_add_file",
            ["gr"] = "git_revert_file",
            ["gc"] = "git_commit",
            ["gp"] = "git_push",
            ["gg"] = "git_commit_and_push",
          },
        },
      },
      example = {
        renderers = {
          custom = {
            {"indent"},
            {"icon", default="C" },
            {"custom"},
            {"name"}
          }
        },
        window = {
          mappings = {
            ["<cr>"] = "toggle_node",
            ["<C-e>"] = "example_command",
            ["d"] = "show_debug_info",
          },
        },
      },
    }
  end,
  config = function(_, opts)
    require('neo-tree').setup(opts)
    -- vim.api.nvim_notify('NeoTreeSetup')
  end
}