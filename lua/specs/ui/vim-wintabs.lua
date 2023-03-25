---@enum displayMethod
local DisplayMethod = {
  --- Wintabs are displayed tabline
  tabline = 'tabline',
  --- Wintabs are displayed in statusline
  statusline = 'statusline', 
  --- Wintabs are not displayed
  none = 'none',
}

---@alias display 
---Wintabs are displayed tabline
---| '"tabline"'
---Wintabs are displayed in statusline
---@see DisplayStatusline.statusline
---| '"statusline"'
---Wintabs are not displayed
---| '"none"'

---@class Display
---Tabs can be displayed in tabline, statusline or not
---@field method displayMethod
---When method is set to `'statusline'`, wintabs occupies
---current statusline and moves the original statusline
---content to tabline
---
---By default, this option is set to what 'original
---statusline' is.
---
---If `vim-airline` is installed, `airline#statusline()` is
---used. Set this option to a custom function like
---`%!MyStatusline()` if you want to show complex and
---customized status on tabline. Set this option to empty
---string to disable this behavior.
---@field statusline string | nil

local AutoClose = {
  ---@enum windowAutoclose
  Window = {
    ---Windows are never closed automatically
    never = 0,
    ---Windows are closed only when there are no listed
    ---wintabs
    empty = 1,
    ---Windows are always closed automatically
    always = 2,
  },
  ---@enum vimTabAutoClose
  VimTab = {
    ---Vim tab is never closed automatically
    never = 0,
    ---Vim tab is always closed automatically
    always = 1,
  },
  ---@enum vimAutoClose
  Vim = {
    ---Vim is never closed automatically
    never = 0,
    ---Vim is always closed automatically
    always = 1,
  },
}

---@enum switchBuf
local SwitchBuf = {
  ---Jump to the first window in current Vim tab that
  ---contains the specific buffer, otherwise open it in the
  ---current window
  findInTab = "useopen",
  ---Search for the buffer in all Vim tabs, if found, jump
  ---to the first window in that Vim tab that contains the
  ---buffer, otherwise open it in the current window
  findInVim = "usetab",
  ---Always open the buffer in the current window
  duplicate = "",
}

---@class AutoClose
---How windows are closed when the last wintab is closed
---using `:WintabsClose`
---@field window windowAutoclose
---How Vim tab is closed when the last window is closed
---@field vimtab vimTabAutoClose
---How Vim is closed when the last window in the only Vim
---tab is closed
---@field vim vimAutoClose

---These characters are drawn before wintabs, between
---wintabs, and after wintabs. It's recommended that they
---have the same length, and are ascii characters.
---@class UiSeparators
---Character drawn before wintabs
---@field leftmost string
---Character drawn between wintabs
---@field inbetween string
---Character drawn after wintabs
---@field rightmost string

---@class UiActiveWintab
---Character drawn around the active wintab (left side)
---@field left string
---Character drawn around the active wintab (right side)
---@field right string

---@class UiActiveVimtab
---Character drawn around the active Vim tab (left side)
---@field left string
---Character drawn around the active Vim tab (right side)
---@field right string

---@class UiActive
---Wintab settings
---@field wintab UiActiveWintab
---Vimtab settings
---@field vimtab UiActiveVimtab
---Highlight group of the active wintab
---@field higroup string

---@class UiNameFormat
---Format of wintab representation
---
---You can specify format of Vim tab representation. By 
---default it is only name of the buffer. But you can use
---the following arguments:
---  - `%t`: Name of buffer
---  - `%n`: `|bufnr()|` of the buffer
---  - `%o`: Ordinal number of the buffer
---@field buffer string
---Format of Vim tab representation
---
---You can specify format of Vim tab representation. By 
---default it is only number of Vim tab. But you can use the
---following arguments:
---  - `%t`: Name of the buffer on this tab
---  - `%n`: Number of the tab
---@field vimtab string

---@class Ui
---Sets the `|'modified'|` mark for modified buffers
---@field modified string
---Sets the `|'readonly'|` mark for readonly buffers
---@field readonly string
---Separators settings for wintabs and Vim tabs
---@field separators UiSeparators
---Active settings for wintabs and Vim tabs
---@field active UiActive
---Name format settings for wintabs and Vim tabs
---@field name_format UiNameFormat
---A dictionary containing all wintabs renderer functions
---
---These functions can be overriden to customize all
---wintabs UI. To see how renderer function works, take a
---look at the default buffer renderer implementation 
---inside `autoload/wintabs/renderers.vim`. 
---vim-wintabs-powerline provides a set of renderers for 
---using Powerline fonts with wintabs.
---@field renderers table<string, function>

---@class VimWintabsConfig
---Controls how window tabs are displayed
---@field display Display
---Controls autoclosed when the last wintab is closed
---using |:WintabsClose|
---@field autoclose AutoClose
---Controls the behavior when switching between buffers
---@field switchbuf switchBuf
---A blacklist of filetypes, based on which buffers are
---ignored by wintabs. Also, |unlisted-buffers| are ignored.
---Defaults to:
---```lua
---{ 'gitcommit', 'vundle', 'qf', 'vimfiler' }
---```
---@field ignored_filetypes string[]
---Controls whether new buffers will be added to the
---beginning of the wintabs list rather than the end
---@field reverse_order boolean
---@field ui Ui

---@type VimWintabsConfig
local defaultOpts = {
  display = {
    method = DisplayMethod.statusline,
    statusline = ""
  },
  autoclose = {
    window = AutoClose.Window.empty,
    vimtab = AutoClose.VimTab.never,
    vim = AutoClose.Vim.never,
  },
  switchbuf = SwitchBuf.findInTab,
  ignored_filetypes = {
    'gitcommit',
    'vundle',
    'qf',
    'vimfiler'
  },
  reverse_order = false,
  ui = {
    modified = ' +',
    readonly = ' -',
    separators = {
      leftmost = '',
      inbetween = '|',
      rightmost = '|',
    },
    active = {
      wintab = {
        left = ' ',
        right = ' ',
      },
      vimtab = {
        left = ' ',
        right = ' ',
      },
      higroup = 'TabLineSel',
    },
    name_format = {
      buffer = ' %t ',
      vimtab = ' %n ',
    }
  }
}

---@type LazyPluginSpec
return {
  'zefei/vim-wintabs',
  enable = false,
  ---@type VimWintabsConfig
  opts = {
    display = {
      method = DisplayMethod.none,
      statusline = ""
    },
    autoclose = {
      window = AutoClose.Window.empty,
      vimtab = AutoClose.VimTab.never,
      vim = AutoClose.Vim.never,
    },
    switchbuf = SwitchBuf.findInTab,
    ignored_filetypes = {
      'gitcommit',
      'vundle',
      'qf',
      'vimfiler',
      'NvimTree',
      'neo-tree'
    },
    reverse_order = false,
    ui = {
      modified = ' +',
      readonly = ' -',
      separators = {
        leftmost = '',
        inbetween = '|',
        rightmost = '|',
      },
      active = {
        wintab = {
          left = ' ',
          right = ' ',
        },
        vimtab = {
          left = ' ',
          right = ' ',
        },
        higroup = 'TabLineSel',
      },
      name_format = {
        buffer = ' %t ',
        vimtab = ' %n ',
      }
    }
  },
  ---@param opts VimWintabsConfig
  config = function(_, opts) 
    vim.g.wintabs_display = opts.display.method
    vim.g.wintabs_autoclose = opts.autoclose.window
    vim.g.wintabs_autoclose_vim = opts.autoclose.vim
    vim.g.wintabs_autoclose_vimtab = opts.autoclose.vimtab
    vim.g.wintabs_switchbuf = opts.switchbuf
    vim.g.wintabs_statusline = opts.display.statusline
    vim.g.wintabs_ignored_filetypes = opts.ignored_filetypes
    vim.g.wintabs_reverse_order = opts.reverse_order
    vim.g.wintabs_ui_modified = opts.ui.modified
    vim.g.wintabs_ui_readonly = opts.ui.readonly
    vim.g.wintabs_ui_sep_leftmost = opts.ui.separators.leftmost
    vim.g.wintabs_ui_sep_inbetween = opts.ui.separators.inbetween
    vim.g.wintabs_ui_sep_rightmost = opts.ui.separators.rightmost
    vim.g.wintabs_ui_active_left = opts.ui.active.wintab.left
    vim.g.wintabs_ui_active_right = opts.ui.active.wintab.right
    vim.g.wintabs_ui_buffer_name_format = opts.ui.name_format.buffer
    vim.g.wintabs_ui_vimtab_name_format = opts.ui.name_format.vimtab
    vim.g.wintabs_ui_active_vimtab_left = opts.ui.active.vimtab.left
    vim.g.wintabs_ui_active_vimtab_right = opts.ui.active.vimtab.right
    vim.g.wintabs_ui_active_higroup = opts.ui.active.higroup
  end,
}
