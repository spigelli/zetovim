local M = {}

function M.on_attach(on_attach)
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local buffer = args.buf
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      on_attach(client, buffer)
    end,
  })
end

local function merge_plugin_files(path)
  local plugins_from_files = {}
  -- Get all files in the directory that end with .lua and are not init.lua
  local files = vim.fn.glob(path .. "/*.lua", true, true)
  -- Remove the init.lua file from the list of files
  files = vim.tbl_filter(function(file)
    return file ~= path .. "/init.lua"
  end, files)
  -- Loop through the files and read the contents
  for _, file in ipairs(files) do
    -- Require the file (should be list of plugin specs)
      -- Convert the file path to a lua module path by only keeping everything
      -- after 'lua/' in the path and replacing / with . andremoving the .lua extension
    local module_path = string.gsub(
      string.gsub(
        string.gsub(
          file,
          vim.fn.stdpath("config") .. "/lua/",
          ""
        ),
        "/",
        "."
      ),
      ".lua",
      ""
    )
    local file_plugins = require(module_path)
    -- Add all elements in the list file_plugins to the end of plugins_from_files
    vim.list_extend(plugins_from_files, file_plugins)
  end
  return plugins_from_files
end

-- Merges submodules into a single table
-- Example:
--   plugins
--   ├───init.lua
--   ├───plugins-1.lua
--   └───submodules
--      ├───submodule-1.lua
--      └───submodule-2.lua
-- Calling M.merge_submodules from plugins/init.lua will return a table with the
-- contents of plugins-1.lua and the contents of both submodule-1.lua and
-- submodule-2.lua
function M.merge_submodules(
  path
)
  local plugins = {}
  -- If path is not defined, use the current directory
  path = path or vim.fn.getcwd()
  vim.list_extend(
    plugins,
    merge_plugin_files(path)
  )
  -- Get all directories in the current directory
  local submodules = vim.fn.glob(path .. "/*", true, true)
  -- For each directory, get the contents of the files in the directory
  for _, submodule in ipairs(submodules) do
      if vim.fn.isdirectory(submodule) == 1 then
          plugins = vim.list_extend(
              plugins,
              M.merge_submodules(submodule)
          )
      end
  end
  return plugins
end

return M
