-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

function options()
    local opt = vim.opt -- to set options
    opt.expandtab = true -- Use spaces instead of tabs
    opt.shiftwidth = 2 -- Size of an indent
    opt.softtabstop = 2 -- Number of spaces that a <Tab> counts for
    opt.tabstop = 2 -- Number of spaces tabs count for
    opt.wrap = false -- Disable line wrap
    opt.hidden = true -- Enable background buffers
    opt.smartcase = true -- Don't ignore case with capitals
    opt.hlsearch = true -- Highlight search results
    opt.incsearch = true -- Incremental search
    opt.showmatch = true -- Show matching brackets
    opt.showmode = false -- Don't show insert/replace mode
    opt.splitbelow = true -- Put new windows below current
    opt.splitright = true -- Put new windows right of current
    opt.termguicolors = true -- True color support
    opt.clipboard = 'unnamedplus' -- Copy paste between vim and everything else
    opt.timeoutlen = 500 -- Time to wait for a mapped sequence to complete (in milliseconds)
    opt.signcolumn = 'yes' -- Always show the signcolumn, otherwise it would shift the text each time
    opt.completeopt = 'menu,menuone,noselect,noinsert,preview' -- Makes it so that you can use <Tab> and <S-Tab> to navigate through popup menu
    opt.autowrite = true -- Enable auto write
    opt.conceallevel = 3 -- Hide * markup for bold and italic
    opt.confirm = true -- Confirm to save changes before exiting modified buffer
    opt.cursorline = false -- Disable highlighting of the current line
    opt.formatoptions = "jcroqlnt" -- tcqj
    opt.grepformat = "%f:%l:%c:%m"
    opt.grepprg = "rg --vimgrep"
    opt.ignorecase = true -- Ignore case
    opt.inccommand = "nosplit" -- preview incremental substitute
    opt.laststatus = 0 -- last window never has status line
    opt.list = true -- Show some invisible characters (tabs...
    opt.mouse = "a" -- Enable mouse mode
    opt.number = true -- Print line number
    opt.pumblend = 10 -- Popup blend
    opt.pumheight = 10 -- Maximum number of entries in a popup
    opt.relativenumber = true -- Relative line numbers
    opt.scrolloff = 8 -- Minimum number of screen lines to keep above and below the cursor
    opt.sidescrolloff = 8 -- Minimum number of screen columns to keep to the left and right of the cursor
    opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize" }
    opt.shiftround = true -- Round indent
    opt.shortmess:append { W = true, I = true, c = true }
    opt.smartindent = true -- Insert indents automatically
    opt.spelllang = { "en" }
    opt.undofile = true
    opt.undolevels = 10000
    opt.updatetime = 200 -- Save swap file and trigger CursorHold
    opt.wildmode = "longest:full,full" -- Command-line completion mode
    opt.winminwidth = 5 -- Minimum window width
    opt.cmdheight = 0 -- Height of the command bar
    opt.fillchars = {
      stl = ' ',
      stlnc = '=',
      wbr = ' ',
      horiz = '─',
      horizup = '┴',
      horizdown = '┬',
      vert = '│',
      vertleft = '┤',
      vertright = '├',
      verthoriz = '┼',
      fold = '·',
      foldopen = '-',
      foldclose = '+',
      foldsep = '|',
      diff = '-',
      msgsep = ' ',
      eob = ' ',
    }
end
return options()