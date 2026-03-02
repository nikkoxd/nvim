vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.api.nvim_buf_create_user_command(0, "PandocConvert", function()
      local file = vim.api.nvim_buf_get_name(0)

      if file == "" then
        vim.notify("No file to convert")
        return
      end

      local pdf_dir = vim.fn.getcwd() .. "/pdf/"
      vim.fn.mkdir(pdf_dir, "p")

      local filename = vim.fn.fnamemodify(file, ":t:r")
      local output = pdf_dir .. filename .. ".pdf"

      local cmd = string.format(
        'pandoc "%s" -s -o "%s" --pdf-engine=xelatex',
        file,
        output
      )

      vim.fn.system(cmd)
      print("PDF generated at: " .. output)
    end, { desc = "Convert markdown to PDF" })
  end,
})
