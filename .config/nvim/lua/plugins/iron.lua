-- local view = require("iron.view")

return {
  "Vigemus/iron.nvim",
  enabled = false,
  cmd = {
    "IronRepl",
    "IronReplHere",
    "IronRestart",
    "IronSend",
    "IronFocus",
    "IronHide",
    "IronWatch",
    "IronAttach",
  },
  keys = {
    "<space>sc",
    "<space>sc",
    "<space>sf",
    "<space>sl",
    "<space>su",
    "<space>sm",
    "<space>mc",
    "<space>mc",
    "<space>md",
    "<space>s<cr>",
    "<space>s<space>",
    "<space>sq",
    "<space>cl",

    { "<space>rs", "<cmd>IronRepl<cr>" },
    { "<space>rr", "<cmd>IronRestart<cr>" },
    { "<space>rf", "<cmd>IronFocus<cr>" },
    { "<space>rh", "<cmd>IronHide<cr>" },
  },
  main = "iron.core", -- <== This informs lazy.nvim to use the entrypoint of `iron.core` to load the configuration.
  opts = {
    config = {
      -- Whether a repl should be discarded or not
      scratch_repl = true,
      -- Your repl definitions come here
      repl_definition = {
        sh = {
          -- Can be a table or a function that
          -- returns a table (see below)
          command = { "fish" },
        },
        bb = {
          command = { "bb nrepl-server" },
        },
      },
      -- How the repl window will be displayed
      -- See below for more information
      -- repl_open_cmd = require('iron.view').bottom(40),
    },
    -- Iron doesn't set keymaps by default anymore.
    -- You can set them here or manually add keymaps to the functions in iron.core
    keymaps = {
      send_motion = "<space>sc",
      visual_send = "<space>sc",
      send_file = "<space>sf",
      send_line = "<space>sl",
      send_until_cursor = "<space>su",
      send_mark = "<space>sm",
      mark_motion = "<space>mc",
      mark_visual = "<space>mc",
      remove_mark = "<space>md",
      cr = "<space>s<cr>",
      interrupt = "<space>s<space>",
      exit = "<space>sq",
      clear = "<space>cl",
    },
    -- If the highlight is on, you can change how it looks
    -- For the available options, check nvim_set_hl
    highlight = { italic = true },
    ignore_blank_lines = true, -- ignore blank lines when sending visual select lines
    repl_open_cmd = {
      vert_DEFUALT = "vertical botright 80 split",
    },
  },
}
