-- local util = require("util")

-- local specs = util.merge_submodules(
--   vim.fn.stdpath("config") .. "/lua/specs"
-- )

-- return specs
return {
  { import = "specs.colors.github-theme" },
  { import = "specs.completion.copilot" },
  { import = "specs.tools.telescope" },
  { import = "specs.ui.dressing" },
  -- { import = "specs.ui.tab-bar" },
  { import = "specs.ui.winbarbar" },
  { import = "specs.ui.virt-column" },
  { import = "specs.tools.terminal" },
  { import = "specs.ui.statusline" },
  { import = "specs.lsp.nvim-lspconfig" },
  { import = "specs.lsp.mason" },
  { import = "specs.lsp.null-ls" },
  { import = "specs.ui.neo-tree" },
  { import = "specs.lsp.tree-sitter" },
  { import = "specs.mapping.legendary" },
};