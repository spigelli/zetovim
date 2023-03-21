local colors = {}

colors.theme = function ()
  local cfg = require('github-theme.config').schema
  local theme = require('github-theme.theme')
  local highlights = theme.setup(cfg)
  return highlights
end

return colors