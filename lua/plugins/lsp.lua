return {
  {
    'neovim/nvim-lspconfig',
    config = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          local opts = { buffer = ev.buf, silent = true }
          opts.desc = "LSP Info"
          vim.keymap.set("n", "<leader>cl", "<cmd>LspInfo<cr>", opts)
          opts.desc = "Show Definitions"
          vim.keymap.set("n", "gd", function()
            Snacks.picker.lsp_definitions()
          end, opts)
          opts.desc = "Show References"
          vim.keymap.set("n", "gr", function()
            Snacks.picker.lsp_references()
          end, opts)
          opts.desc = "Show Implementations"
          vim.keymap.set("n", "gI", function()
            Snacks.picker.lsp_implementations()
          end, opts)
          opts.desc = "Show Type Definitions"
          vim.keymap.set("n", "gy", function()
            Snacks.picker.lsp_type_definitions()
          end, opts)
          opts.desc = "Jump to declaration"
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
          opts.desc = "Display hover information"
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          opts.desc = "Display signature inforamtion"
          vim.keymap.set("n", "<leader>gk", vim.lsp.buf.signature_help, opts)
          opts.desc = "Show code actions"
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
          opts.desc = "Run code lens"
          vim.keymap.set("n", "<leader>cc", vim.lsp.codelens.run, opts)
          opts.desc = "Refresh code lens"
          vim.keymap.set("n", "<leader>cC", vim.lsp.codelens.refresh, opts)
          opts.desc = "Rename"
          vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, opts)
          opts.desc = "Show diagnostics"
          vim.keymap.set("n", "<leader>do", vim.diagnostic.open_float, opts)
          opts.desc = "Format current file"
          vim.keymap.set("n", "<leader>ff", function()
            require("conform").format()
          end, opts)
        end,
      })

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true
      }

      vim.lsp.enable({
        "lua_ls",
        "ts_ls",
        "tailwindcss",
        "eslint"
      })
    end
  },

  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        "~/.local/share/sketchybar_lua/"
      }
    }
  },

  {
    'saghen/blink.cmp',
    dependencies = {
      'l3mon4d3/LuaSnip',
      'folke/lazydev.nvim',
    },

    version = '1.*',

    ---@module 'blink.cmp'
    ---@type blink.cmp.config
    opts = {
      keymap = { preset = 'enter' },
      completion = { documentation = { auto_show = true } },
      snippets = { preset = 'luasnip' },
      sources = {
        default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer' },
        providers = {
          lazydev = {
            name = 'lazydev',
            module = 'lazydev.integrations.blink',
            score_offset = 100,
          },
        },
      },
      fuzzy = { implementation = "prefer_rust_with_warning" },
      signature = { enabled = true },
    },
    opts_extend = { "sources.default" }
  },
}
