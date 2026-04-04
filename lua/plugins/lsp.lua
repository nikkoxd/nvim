return {
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
		},
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

			require("mason-lspconfig").setup()

			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities.textDocument.foldingRange = {
				dynamicRegistration = false,
				lineFoldingOnly = true,
			}

			vim.lsp.config("lua_ls", {
				settings = {
					Lua = {
						workspace = {
							library = vim.api.nvim_get_runtime_file("", true),
						},
					},
				},
			})
		end,
	},

	{
		"saghen/blink.cmp",
		dependencies = {
			"l3mon4d3/LuaSnip",
		},

		version = "1.*",

		---@module 'blink.cmp'
		---@type blink.cmp.config
		opts = {
			keymap = { preset = "enter" },
			completion = { documentation = { auto_show = true } },
			snippets = { preset = "luasnip" },
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
				providers = {},
			},
			fuzzy = { implementation = "prefer_rust_with_warning" },
			signature = { enabled = true },
		},
		opts_extend = { "sources.default" },
	},

	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").setup()
    end,
	},

	{
		"mfussenegger/nvim-dap",
		dependencies = {
			{ "rcarriga/nvim-dap-ui", dependencies = { "nvim-neotest/nvim-nio" } },
			"mason-org/mason.nvim",
			"jay-babu/mason-nvim-dap.nvim",
		},
		keys = {
			{
				"<leader>dd",
				function()
					require("dapui").toggle()
				end,
			},
			{
				"<leader>db",
				function()
					require("dap").toggle_breakpoint()
				end,
				desc = "Toggle Breakpoint",
			},
			{
				"<leader>dc",
				function()
					require("dap").continue()
				end,
				desc = "Continue",
			},
			{
				"<leader>dC",
				function()
					require("dap").run_to_cursor()
				end,
				desc = "Run to Cursor",
			},
			{
				"<leader>dT",
				function()
					require("dap").terminate()
				end,
				desc = "Terminate",
			},
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			dapui.setup()

			require("mason-nvim-dap").setup({
				handlers = {
					function(config)
						require("mason-nvim-dap").default_setup(config)
					end,
				},
			})

			dap.adapters.netcoredbg = {
				type = "executable",
				command = vim.fn.stdpath("data") .. "/mason/packages/netcoredbg/netcoredbg",
				args = { "--interpreter=vscode" },
			}

			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end
			dap.listeners.after.event_initialized.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end
		end,
	},

	{
		"nvim-neotest/neotest",
    lazy = false,
		dependencies = {
			"nvim-neotest/nvim-nio",
      "nvim-treesitter/nvim-treesitter",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"Issafalcon/neotest-dotnet",
      "nsidorenco/neotest-vstest"
		},
		keys = {
			{ "<leader>tr", "<cmd>Neotest run<cr>" },
			{ "<leader>to", "<cmd>Neotest output<cr>" },
			{ "<leader>ts", "<cmd>Neotest summary<cr>" },
			{
				"<leader>td",
				function()
					require("neotest").run.run({ strategy = "dap" })
				end,
			},
			{
				"<leader>ta",
				function()
					require("neotest").run.run({ suite = true })
				end,
			},
		},
		config = function()
			require("neotest").setup({
				adapters = {
					require("neotest-vstest"),
				},
			})
		end,
	},
}
