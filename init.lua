vim.o.guifont = "Symbols Nerd Font Mono,SF Mono:h12"
local config_path  = vim.fn.stdpath("config")
local paths = {
  lazy_installation = config_path .. "/.lazy/lazy.nvim",
  lazy_plugins = config_path .. "/.lazy",
  lazy_lockfile = config_path .. "/.lazy/lockfile.json",
  dev_plugins = config_path .. "/lua/plugins",
  plugins_specs = config_path .. "/lua/specs",
}

if not vim.loop.fs_stat(paths.lazy_installation) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    paths.lazy_installation
  })
end

vim.opt.rtp:prepend(vim.env.LAZY or paths.lazy_installation)

require("config.autocmds")
require("lazy").setup({
  root = paths.lazy_plugins,
  defaults = {
    -- Lazy loading defaults
    lazy = false,
    version = false, -- always use the latest git commit
  },
  spec = {{ import = "specs" }},
  lockfile = paths.lazy_lockfile,
  concurrency = nil,
  ---@diagnostic disable-next-line: assign-type-mismatch
  dev = {
    path = paths.dev_plugins,
    fallback = false,
  },
  install = {
    missing = true,
    colorscheme = nil,
  },
  checker = { enabled = true }, -- automatically check for plugin updates
})

require("config.options")