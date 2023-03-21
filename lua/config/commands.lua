local plugins = require("util.plugins")

local M = {}

function M.toggle_nvim_tree()
  if plugins.isLoaded("nvim-tree.lua") then
    local tree_view = require("nvim-tree.view")
    local tree_api = require("nvim-tree.api")
    local current_tabpage = vim.fn.tabpagenr()
    if tree_view.is_visible({
      tabpage = current_tabpage
    }) then
      local curwin = vim.api.nvim_get_current_win()
      local curwinconfig = vim.api.nvim_win_get_config(curwin)
      local curbuf = vim.api.nvim_win_get_buf(curwin)
      local bufname = vim.api.nvim_buf_get_name(curbuf)
      if not bufname:match("NvimTree") then
        tree_api.tree.focus()
      else
        tree_api.tree.close()
      end
    else
      tree_api.tree.focus()
    end
  else
    -- Notify the user that nvim-tree is not installed
    vim.notify("nvim-tree is not loaded", vim.log.levels.ERROR)
  end
end

function M.toggle_neo_tree()
  local api = vim.api
  local neo_exec = require('neo-tree.command').execute
  local manager = require("neo-tree.sources.manager")
  local neo_tree = require('neo-tree')
  neo_tree.ensure_config()

  local current_filetype = api.nvim_buf_get_option(0,'filetype')
  local is_focused = current_filetype == 'neo-tree'

  if is_focused then
    neo_exec({
      action = 'close',
      position = 'left',
    })
  else
    local source = neo_tree.config.default_source
    local current_window = api.nvim_get_current_win()
    local state = manager.get_state(source, nil, current_window)
    local is_open = state and state.id or false

    if is_open then
      neo_exec({
        action = 'focus',
        position = 'left',
      })
    else
      neo_exec({
        action = 'open',
        position = 'left',
      })
    end
  end
end

vim.g.is_closing = false
function M.close_buffer()
  if plugins.isLoaded("nvim-tree.lua") then
    local tree_view = require("nvim-tree.view")
    local tree_api = require("nvim-tree.api")
    local current_tabpage = vim.fn.tabpagenr()
    if tree_view.is_visible({
      tabpage = current_tabpage
    }) then
        vim.cmd('NvimTreeClose')
        vim.cmd('bd')
    else
      vim.cmd('bd')
      vim.cmd('BufferLineCyclePrev')
    end
  else
    vim.cmd(':q')
    vim.cmd('BufferLineCyclePrev')
  end
end

return M;