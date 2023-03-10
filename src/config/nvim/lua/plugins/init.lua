---
-- @module Plugins
-- @brief Plugin management

local plugins = {}

local function add_plugin(plugin)
  table.insert(plugins, plugin)
end

-- Enumerate plugins
local function enumerate_plugins()
  local plugin_dir = vim.fn.stdpath("config") .. "/lua/plugins"
  -- Sub directories of the plugin directory
  -- Set the wildignore option to ignore all files
  vim.cmd("set wildignore+=**")
  local plugin_dirs = vim.fn.glob(plugin_dir .. "/**", true, true)

  -- Filter out any non directories
  plugin_dirs = vim.tbl_filter(function(dir)
    return vim.fn.isdirectory(dir) == 1
  end, plugin_dirs)

  -- Iterate over the sub directories creating a module path for each
  local plugin_paths = {}
  for _, dir in ipairs(plugin_dirs) do
    local plugin_name = vim.fn.fnamemodify(dir, ":t")
    local plugin_path = plugin_name
    table.insert(plugin_paths, plugin_path)
  end
  print(vim.inspect(plugin_paths))
end

local plugin_paths = enumerate_plugins()

-- Load plugins
local function load_plugins()
  for _, plugin_path in ipairs(plugin_paths) do
    add_plugin(require(plugin_path))
  end
end

return plugins;