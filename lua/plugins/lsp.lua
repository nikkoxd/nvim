return {
  {
    'neovim/nvim-lspconfig',
    config = function()
      vim.api.nvim_create_autocmd("lspattach", {
        group = vim.api.nvim_create_augroup("userlspconfig", {}),
        callback = function(ev)
          local opts = { buffer = ev.buf, silent = true }
          opts.desc = "lsp info"
          vim.keymap.set("n", "<leader>cl", "<cmd>lspinfo<cr>", opts)
          opts.desc = "show definitions"
          vim.keymap.set("n", "gd", function()
            snacks.picker.lsp_definitions()
          end, opts)
          opts.desc = "show references"
          vim.keymap.set("n", "gr", function()
            snacks.picker.lsp_references()
          end, opts)
          opts.desc = "show implementations"
          vim.keymap.set("n", "gi", function()
            snacks.picker.lsp_implementations()
          end, opts)
          opts.desc = "show type definitions"
          vim.keymap.set("n", "gy", function()
            snacks.picker.lsp_type_definitions()
          end, opts)
          opts.desc = "jump to declaration"
          vim.keymap.set("n", "gd", vim.lsp.buf.declaration, opts)
          opts.desc = "display hover information"
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          opts.desc = "display signature inforamtion"
          vim.keymap.set("n", "<leader>gk", vim.lsp.buf.signature_help, opts)
          opts.desc = "show code actions"
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
          opts.desc = "run code lens"
          vim.keymap.set("n", "<leader>cc", vim.lsp.codelens.run, opts)
          opts.desc = "refresh code lens"
          vim.keymap.set("n", "<leader>cc", vim.lsp.codelens.refresh, opts)
          opts.desc = "rename"
          vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, opts)
          opts.desc = "show diagnostics"
          vim.keymap.set("n", "<leader>do", vim.diagnostic.open_float, opts)
          opts.desc = "format current file"
          vim.keymap.set("n", "<leader>ff", vim.lsp.buf.format, opts)
        end,
      })

      vim.lsp.enable({
        "lua_ls",
        "ts_ls",
        "tailwindcss"
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
