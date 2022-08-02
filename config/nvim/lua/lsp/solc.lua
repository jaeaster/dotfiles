local M = {}

M.setup = function(on_attach, capabilities)
	require("lspconfig")["solc"].setup({
		-- cmd = { "solc", "--lsp", "--base-path", "./", "--include-path", "./lib", "$(forge remappings)" },
		on_attach = on_attach,
		capabilities = capabilities,
	})
end

return M
