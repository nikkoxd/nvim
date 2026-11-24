---@diagnostic disable: missing-fields
---@diagnostic disable: undefined-global

-- INFO: options
-- these change the default neovim behaviours using the 'vim.opt' API.
-- see `:h vim.opt` for more details.
-- run `:h '{option_name}'` to see what they do and what values they can take.
-- for example, `:h 'number'` for `vim.opt.number`.

-- set <space> as the leader key
-- must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- enable true color support
vim.opt.termguicolors = true

-- make line numbers default
vim.opt.number = true
vim.opt.relativenumber = true

-- enable mouse mode, can be useful for resizing splits
vim.opt.mouse = "a"

-- sync clipboard between OS and neovim.
--  remove this option if you want your OS clipboard to remain independent.
--  see `:help 'clipboard'`
vim.opt.clipboard = "unnamedplus"

-- save undo history
vim.opt.undofile = true

-- keep signcolumn on by default
vim.opt.signcolumn = "yes"

-- sets how neovim will display certain whitespace characters in the editor.
--  see `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣", }

-- enable live preview of substitutions
vim.opt.inccommand = "split"

-- show which line your cursor is on
vim.opt.cursorline = true

-- set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true

-- enable break indent
vim.opt.breakindent = true

-- enable line wrapping
vim.opt.wrap = true

-- formatting
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.textwidth = 80

-- must cover the same characters as langmapper's layouts, or punctuation
-- mappings won't be translated back in normal mode
local function escape(str)
  return vim.fn.escape(str, [[;,."|\]])
end

-- vim.o (not vim.opt) so the escaped commas/semicolons are parsed by vim itself
vim.o.langmap = vim.fn.join({
  escape([[ËЙЦУКЕНГШЩЗХЪ/ФЫВАПРОЛДЖЭЯЧСМИТЬБЮ,]]) .. ";" .. escape([[~QWERTYUIOP{}|ASDFGHJKL:"ZXCVBNM<>?]]),
  escape([[ёйцукенгшщзхъфывапролджэячсмитьбю.]]) .. ";" .. escape([[`qwertyuiop[]asdfghjkl;'zxcvbnm,./]]),
}, ",")

vim.pack.add({ "https://github.com/Wansmer/langmapper.nvim" }, { confirm = false })

-- vim.pack loads plugins synchronously, so setting up right after `add`
-- replaces lazy.nvim's `lazy = false, priority = 1`. hack_keymap then wraps
-- all later vim.keymap.set / nvim_set_keymap calls with auto-translation.
require("langmapper").setup({
  hack_keymap = true,
  layouts = {
    ru = {
      -- must match the layout name reported by `niri msg keyboard-layouts`
      id = "Russian",
    },
  },
  os = {
    Linux = {
      -- query niri's IPC for the active layout (xkb-switch is X11-only)
      get_current_layout_id = function()
        local out = vim.fn.system("niri msg --json keyboard-layouts")
        local ok, info = pcall(vim.json.decode, out)
        if ok then return info.names[info.current_idx + 1] end
      end,
    },
  },
})

vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.INFO] = " ",
      [vim.diagnostic.severity.HINT] = " ",
    },
  },
  virtual_text = true, -- show inline diagnostics
})

-- clear search highlights with <Esc>
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "<leader>fs", "<cmd>write<CR>")
vim.keymap.set("v", "<leader>x", ":lua<CR>", { desc = "Execute selected lines" })

vim.keymap.set("n", "<leader>bp", "<cmd>bprevious<cr>")
vim.keymap.set("n", "<leader>bn", "<cmd>bnext<cr>")
vim.keymap.set("n", "<leader>bk", "<cmd>bd<cr>")

vim.keymap.set("n", "<leader>w", "<C-w>")
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

vim.pack.add({ "https://github.com/slugbyte/lackluster.nvim" }, { confirm = false })
vim.cmd.colorscheme("lackluster")

-- INFO: formatting and syntax highlighting
vim.pack.add({ "https://github.com/nvim-treesitter/nvim-treesitter" }, { confirm = false })

-- start treesitter highlighting on buffers that have a parser available
vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
    if lang and vim.treesitter.language.add(lang) then
      vim.treesitter.start(args.buf, lang)
    end
  end,
})

-- INFO: completion engine
vim.pack.add({ "https://github.com/saghen/blink.lib" }, { confirm = false })
vim.pack.add({ "https://github.com/saghen/blink.cmp" }, { confirm = false })

require("blink.cmp").setup({
  completion = {
    documentation = {
      auto_show = true,
    },
  },

  -- default blink keymaps
  keymap = {
    ['<C-p>'] = { 'select_prev', 'fallback_to_mappings' },
    ['<C-n>'] = { 'select_next', 'fallback_to_mappings' },

    ['<C-y>'] = { 'select_and_accept', 'fallback' },
    ['<C-e>'] = { 'cancel', 'fallback' },
    ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },

    ['<Tab>'] = { 'snippet_forward', 'fallback' },
    ['<S-Tab>'] = { 'snippet_backward', 'fallback' },

    ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
    ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },

    ['<C-k>'] = { 'show_signature', 'hide_signature', 'fallback' },
  },

  fuzzy = {
    implementation = "lua",
  },
})

-- INFO: lsp server installation and configuration

-- lsp servers we want to use and their configuration
-- see `:h lspconfig-all` for available servers and their settings
local lsp_servers = {
  lua_ls = {
    -- https://luals.github.io/wiki/settings/ | `:h nvim_get_runtime_file`
    Lua = { workspace = { library = vim.api.nvim_get_runtime_file("lua", true) }, },
  },
  clangd = {},
  rust_analyzer = {},
  gopls = {},
}

vim.pack.add({
  "https://github.com/neovim/nvim-lspconfig", -- default configs for lsps
  "https://github.com/mason-org/mason.nvim",                     -- package manager
  "https://github.com/mason-org/mason-lspconfig.nvim",           -- lspconfig bridge
  "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim" -- auto installer
}, { confirm = false })

require("mason").setup()
require("mason-lspconfig").setup()
require("mason-tool-installer").setup({
  ensure_installed = vim.tbl_keys(lsp_servers),
})

-- configure each lsp server on the table
-- to check what clients are attached to the current buffer, use
-- `:checkhealth vim.lsp`. to view default lsp keybindings, use `:h lsp-defaults`.
for server, config in pairs(lsp_servers) do
  vim.lsp.config(server, {
    settings = config,

    -- only create the keymaps if the server attaches successfully
    on_attach = function(_, bufnr)
      vim.keymap.set("n", "grd", vim.lsp.buf.definition,
        { buffer = bufnr, desc = "vim.lsp.buf.definition()", })

      vim.keymap.set("n", "grf", vim.lsp.buf.format,
        { buffer = bufnr, desc = "vim.lsp.buf.format()", })
    end,
  })
end

-- INFO: snacks 🍿
vim.pack.add({ "https://github.com/folke/snacks.nvim" }, { confirm = false })

require("snacks").setup({
  bigfile = { enabled = true },
  gitbrowse = { enabled = true },
  input = { enabled = true },
  picker = { enabled = true, layout = { preset = "ivy", layout = { position = "bottom" } } },
  rename = { enabled = true },
  terminal = { enabled = true },
  statuscolumn = { enabled = true },
  words = { enabled = true },
})

vim.keymap.set("n", "<leader><leader>", function() Snacks.picker.files() end, { desc = "Project files" })
vim.keymap.set("n", "<leader>fp", function() Snacks.picker.files() end, { desc = "Project files" })
vim.keymap.set("n", "<leader>fr", function() Snacks.picker.recent() end, { desc = "Recent files" })
vim.keymap.set("n", "<leader>/", function() Snacks.picker.grep() end, { desc = "Grep" })
vim.keymap.set("n", "<leader>bf", function() Snacks.picker.buffers() end, { desc = "Buffers" })
vim.keymap.set("n", "<leader>pf", function() Snacks.picker.projects() end, { desc = "Projects" })
vim.keymap.set("n", "<leader>nf", function() Snacks.picker.files({ cwd = "~/Notes/typst", exclude = { "*.pdf" } }) end, { desc = "Notes" })

vim.keymap.set("n", "<leader>gb", function() Snacks.picker.git_branches() end, { desc = "Git Branches" })
vim.keymap.set("n", "<leader>gl", function() Snacks.picker.git_log() end, { desc = "Git Log" })
vim.keymap.set("n", "<leader>gL", function() Snacks.picker.git_log_line() end, { desc = "Git Log Line" })
vim.keymap.set("n", "<leader>gs", function() Snacks.picker.git_status() end, { desc = "Git Status" })
vim.keymap.set("n", "<leader>gS", function() Snacks.picker.git_stash() end, { desc = "Git Stash" })
vim.keymap.set("n", "<leader>gd", function() Snacks.picker.git_diff() end, { desc = "Git Diff (Hunks)" })
vim.keymap.set("n", "<leader>gf", function() Snacks.picker.git_log_file() end, { desc = "Git Log File" })

vim.keymap.set("n", "<leader>th", function() Snacks.picker.colorschemes() end, { desc = "Colorschemes" })
vim.keymap.set("n", "<leader>hl", function() Snacks.picker.highlights() end, { desc = "Highlights" })
vim.keymap.set("n", "<leader>vk", function() Snacks.picker.keymaps() end, { desc = "Vim keymaps" })
vim.keymap.set("n", "<leader>vh", function() Snacks.picker.help() end, { desc = "Vim help" })
vim.keymap.set("n", "<leader>vm", function() Snacks.picker.help({ layout = { preview = "main" } }) end, { desc = "Manpages" })

vim.keymap.set("n", "<leader>z", function() Snacks.zen() end, { desc = "Toggle zen mode" })
vim.keymap.set("n", "<leader>gB", function() Snacks.gitbrowse() end, { desc = "Open tracked file on web" })
vim.keymap.set("n", "<leader>ot", function() Snacks.terminal() end, { desc = "Terminal" })
vim.keymap.set({ "n", "t" }, "]]", function() Snacks.words.jump(vim.v.count1) end, { desc = "Next reference" })
vim.keymap.set({ "n", "t" }, "[[", function() Snacks.words.jump(-vim.v.count1) end, { desc = "Prev reference" })

-- INFO: Git
vim.pack.add({ "https://github.com/sindrets/diffview.nvim" }, { confirm = false })
vim.pack.add({ "https://github.com/m00qek/baleia.nvim" }, { confirm = false })
vim.pack.add({ "https://github.com/neogitorg/neogit" }, { confirm = false })

vim.keymap.set("n", "<leader>gg", "<cmd>Neogit<cr>", { desc = "Terminal" })

-- INFO: file manager
vim.pack.add({ "https://github.com/stevearc/oil.nvim" }, { confirm = false })

require("oil").setup({})

vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- INFO: keybinding helper
vim.pack.add({ "https://github.com/folke/which-key.nvim" }, { confirm = false })

require("which-key").setup({})

-- INFO: typst notetaking
vim.pack.add({ "https://github.com/chomosuke/typst-preview.nvim" }, { confirm = false })

require("typst-preview").setup({})

vim.keymap.set("n", "<leader>tp", "<cmd>TypstPreviewToggle<cr>", { desc = "Typst Preview" })

-- INFO: surround
vim.pack.add({ "https://github.com/tpope/vim-surround" }, { confirm = false })

-- INFO: color picker + previews
vim.pack.add({ "https://github.com/uga-rosa/ccc.nvim" }, { confirm = false })

local ccc = require("ccc")
ccc.setup {
  highlighter = {
    auto_enable = true,
    lsp = true,
  },
}

require('langmapper').automapping({ global = true, buffer = true })
