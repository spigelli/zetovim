---@diagnostic disable: duplicate-index
vim.api.nvim_create_autocmd(
  "TermOpen",
  {
    pattern = "term://*",
    callback = function()
      vim.api.nvim_buf_set_keymap(0, "t", "esc", "<C-\\><C-n>", {})
      vim.api.nvim_buf_set_keymap(0, "t", "<C-[>", "<C-\\><C-n>", {})
      vim.api.nvim_buf_set_keymap(0, "t", "^[", "<C-\\><C-n>", {})
    end
  }
)

function hl_name()
  vim.notify("highligh: " .. require('treesitter').statusline(90))
end

require('lazy')
