local null_ls = require("null-ls")
local b = null_ls.builtins

local sources = {
  b.formatting.stylua,
  b.formatting.prettier,

  b.diagnostics.solhint,

  b.completion.spell,
}

local M = {}
M.setup = function(on_attach)
  null_ls.setup({
    sources = sources,
    on_attach = on_attach,
  })
end

return M
