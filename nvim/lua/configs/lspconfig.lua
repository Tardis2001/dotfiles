-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

local servers = { "html", "cssls", "clangd", "marksman", "ltex", "ts_ls" }
local nvlsp = require "nvchad.configs.lspconfig"

for _, lsp in ipairs(servers) do
  if lsp == "clangd" then
    lspconfig.clangd.setup {
      on_attach = nvlsp.on_attach,
      on_init = nvlsp.on_init,
      capabilities = nvlsp.capabilities,
      cmd = { "clangd", "--background-index" },
      filetypes = { "c", "cpp" },
      root_dir = function() return vim.loop.cwd() end,
      single_file_support = true,
    }
  elseif lsp == "lua_ls" then
    lspconfig.lua_ls.setup {
      on_attach = nvlsp.on_attach,
      on_init = nvlsp.on_init,
      capabilities = nvlsp.capabilities,
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            library = {
              vim.env.VIMRUNTIME,
              "${3rd}/luv/library",
            },
          },
        },
      },
    }
  elseif lsp == "marksman" then
    lspconfig.marksman.setup {
      on_attach = nvlsp.on_attach,
      on_init = nvlsp.on_init,
      capabilities = nvlsp.capabilities,
      filetypes = { "markdown" }, -- Só para markdown
    }
  elseif lsp == "ltex" then
    lspconfig.ltex.setup {
      cmd = { "/usr/bin/ltex-ls-plus" },
      on_attach = nvlsp.on_attach,
      on_init = nvlsp.on_init,
      capabilities = nvlsp.capabilities,
      settings = {
        ltex = {
          language = "pt-BR",
          additionalLanguages = { "en-US", "es-ES" },
          diagnosticSeverity = "information",
          setenceCacheSize = 5000,
        },
      },
      filetypes = { "markdown", "tex", "plaintex" },
    }
  elseif lsp == "html" then
    -- Configuração do servidor HTML
    lspconfig.html.setup {
      cmd = { "vscode-html-languageserver", "--stdio" },
      filetypes = { "html", "htmldjango" },
      settings = {
        html = {
          suggest = { html5 = true },
        },
      },
      on_attach = nvlsp.on_attach,
      on_init = nvlsp.on_init,
      capabilities = nvlsp.capabilities,
    }
  elseif lsp == "cssls" then
    -- Configuração do servidor CSS
    lspconfig.cssls.setup {
      cmd = { "vscode-css-languageserver", "--stdio" },
      filetypes = { "css", "scss", "less" },
      settings = {
        css = {
          validate = true,
        },
        scss = {
          validate = true,
        },
        less = {
          validate = true,
        },
      },
      on_attach = nvlsp.on_attach,
      on_init = nvlsp.on_init,
      capabilities = nvlsp.capabilities,
    }
  elseif lsp == "ts_ls" then
    lspconfig.ts_ls.setup {
      cmd = { "typescript-language-server", "--stdio" },
      filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
      root_dir = lspconfig.util.root_pattern("tsconfig.json", "package.json"),
      on_attach = nvlsp.on_attach,
      on_init = nvlsp.on_init,
      capabilities = nvlsp.capabilities,
    }
  else
    lspconfig[lsp].setup {
      on_attach = nvlsp.on_attach,
      on_init = nvlsp.on_init,
      capabilities = nvlsp.capabilities,
    }
  end
end


-- configuring single server, example: typescript
-- lspconfig.ts_ls.setup {
--   on_attach = nvlsp.on_attach,
--   on_init = nvlsp.on_init,
--   capabilities = nvlsp.capabilities,
-- }
