require("nvchad.configs.lspconfig").defaults()

local servers = {
  "pyright",  -- Python
  "ts_ls",    -- TypeScript / JavaScript
  "html",     -- HTML
  "cssls",    -- CSS
  "clangd",   -- C, C++
  "jdtls",    -- Java
  "sqlls",    -- SQL
}

vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers 
