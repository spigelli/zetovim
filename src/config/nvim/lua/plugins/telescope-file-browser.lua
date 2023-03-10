-- lazyvim schema for telescope file file_browser
---@class LazyKeys
---@field [1] string lhs
---@field [2]? string|fun()|false rhs
---@field desc? string
---@field mode? string|string[]
---@field noremap? boolean
---@field remap? boolean
---@field expr? boolean
---@field id string

--[[
mappings = {
  ["i"] = {
    ["<A-c>"] = fb_actions.create,
    ["<S-CR>"] = fb_actions.create_from_prompt,
    ["<A-r>"] = fb_actions.rename,
    ["<A-m>"] = fb_actions.move,
    ["<A-y>"] = fb_actions.copy,
    ["<A-d>"] = fb_actions.remove,
    ["<C-o>"] = fb_actions.open,
    ["<C-g>"] = fb_actions.goto_parent_dir,
    ["<C-e>"] = fb_actions.goto_home_dir,
    ["<C-w>"] = fb_actions.goto_cwd,
    ["<C-t>"] = fb_actions.change_cwd,
    ["<C-f>"] = fb_actions.toggle_browser,
    ["<C-h>"] = fb_actions.toggle_hidden,
    ["<C-s>"] = fb_actions.toggle_all,
  },
  ["n"] = {
    ["c"] = fb_actions.create,
    ["r"] = fb_actions.rename,
    ["m"] = fb_actions.move,
    ["y"] = fb_actions.copy,
    ["d"] = fb_actions.remove,
    ["o"] = fb_actions.open,
    ["g"] = fb_actions.goto_parent_dir,
    ["e"] = fb_actions.goto_home_dir,
    ["w"] = fb_actions.goto_cwd,
    ["t"] = fb_actions.change_cwd,
    ["f"] = fb_actions.toggle_browser,
    ["h"] = fb_actions.toggle_hidden,
    ["s"] = fb_actions.toggle_all,
  },
},
]]--

return {
  {
    "nvim-telescope/telescope-file-browser.nvim",
    opts = function()
      local fb_actions = require("telescope._extensions.file_browser.actions")
      return {
        ---@type LazyKeys[]
      }
    end,
    keys = {
      {
        "n",
        function()
          fb_actions.create()
        end,
        mode="n",
        desc="New File",
      },
      -- ["r"] = { fb_actions.rename, mode="n" },
      -- ["m"] = { fb_actions.move, mode="n" },
      -- ["y"] = { fb_actions.copy, mode="n" },
      -- ["d"] = { fb_actions.remove, mode="n" },
      -- ["o"] = { fb_actions.open, mode="n" },
      -- ["g"] = { fb_actions.goto_parent_dir, mode="n" },
      -- ["e"] = { fb_actions.goto_home_dir, mode="n" },
      -- ["w"] = { fb_actions.goto_cwd, mode="n" },
      -- ["t"] = { fb_actions.change_cwd, mode="n" },
      -- ["f"] = { fb_actions.toggle_browser, mode="n" },
      -- ["h"] = { fb_actions.toggle_hidden, mode="n" },
      -- ["s"] = { fb_actions.toggle_all, mode="n" },
      
      -- ["<M-n>"] = {
      --   fb_actions.create,
      --   mode="i",
      --   desc="New file",
      -- },
      -- [false] = { fb_actions.create_from_prompt, mode="i" },
      -- ["<M-r>"] = { fb_actions.rename, mode="i" },
      -- ["<M-m>"] = { fb_actions.move, mode="i" },
      -- ["<M-y>"] = { fb_actions.copy, mode="i" },
      -- ["<M-d>"] = { fb_actions.remove, mode="i" },
      -- ["<C-S-o>"] = { fb_actions.open, mode="i" },
      -- [false] = { fb_actions.goto_parent_dir, mode="i" },
      -- ["<M-e>"] = { fb_actions.goto_home_dir, mode="i" },
      -- ["<M-w>"] = { fb_actions.goto_cwd, mode="i" },
      -- ["<M-t>"] = { fb_actions.change_cwd, mode="i" },
      -- ["<M-f>"] = { fb_actions.toggle_browser, mode="i" },
      -- ["<M-h>"] = { fb_actions.toggle_hidden, mode="i" },
      -- ["<M-s>"] = { fb_actions.toggle_all, mode="i" },
    },
  },
}

          -- Ensure default mappings are disabled
          -- ["<A-c>"] = false,
          -- ["<S-CR>"] = false,
          -- ["<A-r>"] = false,
          -- ["<A-m>"] = false,
          -- ["<A-y>"] = false,
          -- ["<A-d>"] = false,
          -- ["<C-o>"] = false,
          -- ["<C-g>"] = false,
          -- ["<C-e>"] = false,
          -- ["<C-w>"] = false,
          -- ["<C-t>"] = false,
          -- ["<C-f>"] = false,
          -- ["<C-h>"] = false,
          -- ["<C-s>"] = false,
          -- ["c"] = false,
          -- ["r"] = false,
          -- ["m"] = false,
          -- ["y"] = false,
          -- ["d"] = false,
          -- ["o"] = false,
          -- ["g"] = false,
          -- ["e"] = false,
          -- ["w"] = false,
          -- ["t"] = false,
          -- ["f"] = false,
          -- ["h"] = false,
          -- ["s"] = false,
          -- ["n"] = { fb_actions.create, mode="n", desc="New File" },