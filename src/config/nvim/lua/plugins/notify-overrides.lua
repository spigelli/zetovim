return {
  {
    "rcarriga/nvim-notify",
    keys = {
      {
        "<leader>un",
        function()
          require("notify").dismiss({ silent = true, pending = true })
        end,
        desc = "Delete all Notifications",
      },
    },
    opts = {
      timeout = 6000,
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.75)
      end,
      background_colour = "#000000",
    },
    init = function()
      --   vim.notify("Notify Overrides", vim.log.levels.INFO, { title = "INIT" })
      -- end,
      -- config = function()
      vim.notify("Notify Overrides", vim.log.levels.INFO, { title = "Config" })
      -- when noice is not enabled, install notify on VeryLazy
      local Util = require("lazyvim.util")

      if not Util.has("noice.nvim") then
        Util.on_very_lazy(function()
          vim.notify = require("notify")
        end)
      end

      if not Util.has("github-theme") then
        vim.notify = require("notify")
        vim.notify(
          "Tried to set new options for notify, but github-theme is not initialized",
          vim.log.levels.ERROR,
          { title = "Notify Overrides" }
        )
        Util.on_very_lazy(function()
          vim.notify = require("notify")
        end)
      end

      local github_config = Util.opts("github-theme")
      if github_config == nil then
        vim.notify(
          "Tried to set new options for notify, but github-theme is not initialized",
          vim.log.levels.ERROR,
          { title = "Notify Overrides" }
        )
        Util.on_very_lazy(function()
          vim.notify = require("notify")
        end)
      end

      -- Sinc github-theme is loaded, we can use it to set the colors for notify
      local theme_config = require("github-theme.config")

      -- "github-theme".theme.setup(cfg) returns highlights
      local hi = require("github-theme.theme").setup(theme_config.schema)

      local hilight_keys = {
        "NotifyERRORTitle",
        "NotifyWARNTitle",
        "NotifyINFOTitle",
        "NotifyDEBUGTitle",
        "NotifyTRACETitle",
        "NotifyERRORIcon",
        "NotifyWARNIcon",
        "NotifyINFOIcon",
        "NotifyDEBUGIcon",
        "NotifyTRACEIcon",
        "NotifyERRORBorder",
        "NotifyWARNBorder",
        "NotifyINFOBorder",
        "NotifyDEBUGBorder",
        "NotifyTRACEBorder",
        "NotifyERRORBody",
        "NotifyWARNBody",
        "NotifyINFOBody",
        "NotifyDEBUGBody",
        "NotifyTRACEBody",
      }

      --[[
        For each key in hilight_keys:
          The value of that key in hi.plugins is either
          a table with fg (the color we want) or
          a table with link (another key that has the color we want in hi.plugins[key[link\]\][fg])
        This loop will create a table with just the keys and colors
      ]]
      --
      local colors = {}
      for _, key in ipairs(hilight_keys) do
        local color = hi.plugins[key]
        if color.link ~= nil then
          color = hi.plugins[color.link].fg
        else
          color = color.fg
        end
        colors[key] = color
      end

      --[[
        Loop over the colors table and create vim commands to set the colors
      ]]
      --
      local commands = ""
      for key, color in pairs(colors) do
        local command = "hi default " .. key .. " guifg=" .. color .. "\n"
        commands = commands .. command
      end

      local set_highlight_command = "hi default link NotifyBackground Normal\n"
        .. commands
        .. "hi default link NotifyLogTime Comment\n"
        .. "hi default link NotifyLogTitle Special\n"

      vim.notify(set_highlight_command, vim.log.levels.ERROR, { title = "Notify Overrides" })

      -- Set the colors
      vim.cmd(set_highlight_command)
    end,
  },
}
