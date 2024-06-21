return {
  "neovim/nvim-lspconfig",

  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp"
  },

  config = function()
    local cmp_nvim_lsp = require("cmp_nvim_lsp");
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        local opts = { buffer = ev.buf, silent = true }
        vim.keymap.set("n", "<leader>cl", "<cmd>LspInfo<cr>", opts)
        vim.keymap.set("n", "gd", require("telescope.builtin").lsp_definitions, opts)
        vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references, opts)
        vim.keymap.set("n", "gI", require("telescope.builtin").lsp_implementations, opts)
        vim.keymap.set("n", "gy", require("telescope.builtin").lsp_type_definitions, opts)
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "gK", vim.lsp.buf.signature_help, opts)
        vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "<leader>cc", vim.lsp.codelens.run, opts)
        vim.keymap.set("n", "<leader>cC", vim.lsp.codelens.refresh, opts)
        vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<leader>do", vim.diagnostic.open_float, opts)
      end,
    })

    local capabilities = cmp_nvim_lsp.default_capabilities()

    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = {
        "lua_ls",
        "astro",
        "eslint",
        "tsserver",
        "tailwindcss",
      },

      handlers = {
        function (server_name)
          require("lspconfig")[server_name].setup {}
        end,

        ["lua_ls"] = function ()
          local lspconfig = require("lspconfig")
          lspconfig.lua_ls.setup {
            settings = {
              Lua = {
                diagnostics = {
                  globals = { "vim" }
                }
              }
            }
          }
        end,
      }
    })

    require("lspconfig")["gdscript"].setup({
      name = "godot",
      cmd = vim.lsp.rpc.connect("127.0.0.1", "6005"),
    })

    require("lspconfig")["gdshader_lsp"].setup({})
  end
}
