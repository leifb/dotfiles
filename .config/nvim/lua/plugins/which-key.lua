return {
  "folke/which-key.nvim",
  opts = function()
    require("which-key").add({
      { "<leader>r", name = "+repl", icon = { icon = "", color = "red" } },
    })
  end,
}
