return {
  "pappasam/nvim-repl",
  init = function()
    vim.g["repl_filetype_commands"] = {
      bash = "bash",
      babashka = { cmd = "bb" },
      xonsh = { cmd = "xonsh" },
      javascript = "node",
      haskell = "ghci",
      ocaml = { cmd = "utop", suffix = ";;" },
      python = "ipython --no-autoindent",
      r = "R",
      sh = "sh",
      vim = "nvim --clean -ERM",
      zsh = "zsh",
    }
  end,
  -- Note: Group <leader>r is defined in which-key.lua
  keys = {
    -- Create new repls
    { "<Leader>rnb", "<Cmd>ReplOpen bb<CR>", mode = "n", desc = "New Babashka Repl" },
    { "<Leader>rnx", "<Cmd>ReplOpen xonsh<CR>", mode = "n", desc = "New Xonsh Repl" },
    -- Send stuff to repl
    { "<Leader>rc", "<Plug>(ReplSendCell)", mode = "n", desc = "Send Repl Cell" },
    { "<Leader>rr", "<Plug>(ReplSendLine)", mode = "n", desc = "Send Repl Line" },
    { "<Leader>rr", "<Plug>(ReplSendVisual)", mode = "x", desc = "Send Repl Visual Selection" },
  },
}
