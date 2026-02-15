vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.tabstop = 2

vim.api.nvim_create_autocmd("FileType", {
  pattern = "nix",
  callback = function()
    vim.bo.expandtab = true
    vim.bo.shiftwidth = 2
    vim.bo.tabstop = 2
  end,
})

vim.lsp.config("lua_ls", {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = { ".git", "init.lua" }, -- optional but nice
  settings = {
    Lua = {
      format = {
        enable = true
      },
      diagnostics = {
        globals = { "vim" }, -- prevent "undefined global vim"
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      telemetry = {
        enable = false,
      },
    },
  },
})

vim.lsp.enable("lua_ls")

-- Neovim 0.11+ native LSP config
vim.lsp.config("nixd", {
  cmd = { "nixd" },
  filetypes = { "nix" },
  root_markers = { "flake.nix", ".git" },
})

vim.lsp.enable("nixd")

vim.o.completeopt = "menu,menuone,noinsert"

vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function(args)
    if vim.api.nvim_buf_line_count(args.buf) > 5000 then
      return
    end

    local ft = vim.bo[args.buf].filetype

    if ft == "nix" then
      local view = vim.fn.winsaveview()
      vim.cmd("%!nixfmt")
      vim.fn.winrestview(view)
      return
    end

    local clients = vim.lsp.get_clients({ bufnr = args.buf })
    if #clients > 0 then
      vim.lsp.buf.format({ bufnr = args.buf })
    end
  end,
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    vim.lsp.completion.enable(true, args.data.client_id, args.buf, { autotrigger = true })
  end,
})
