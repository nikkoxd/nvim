return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      javascript = "prettierd",
      typescript = "prettierd",
      javascriptreact = "prettierd",
      typescriptreact = "prettierd",
    },
    default_format_opts = { lsp_format = "fallback" },
  }
}
