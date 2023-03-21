local colors = {}

---@return gt.Highlights
colors.theme = function ()
  ---@type gt.ConfigSchema
  local cfg = require('github-theme.config').schema
  local theme = require('github-theme.theme')
  local highlights = theme.setup(cfg)
  return highlights
end

return colors