local M = {
  'jpalardy/vim-slime',
  ft = { "ocaml"},
  -- name = "vim-slime"
}

function M.init()
  vim.g.slime_target = "neovim" -- or "tmux"
  vim.g.slime_menu_config=1
end

function M.config()
  local repl = "utop"
  local replid
  local cmd

  local function dune_proj()
    local found = vim.fn.findfile("dune", ".;")
    if found ~= "" then
      return true
    else
      return false
    end
  end

  function GetMlId()
    if replid ~= nil then
      print(replid)
    else
      print("No Active Repl...")
    end
  end

  function OpenMLRepl()
    if cmd == nil then
      if dune_proj() then
        cmd = "dune " .. repl
      else
        cmd = "ocaml"
      end
    end
    cmd = vim.fn.input("=> ", cmd)
    local pos = vim.fn.input("H,J,K,L => ")

    vim.cmd("wincmd n")
    vim.cmd("wincmd " .. pos)

    local terminal_width = 40
    local terminal_height = 12

    local opposite_pos
    if pos == "H" then
      vim.cmd("vertical resize " .. terminal_width)
      opposite_pos = "l"
    elseif pos == "L" then
      vim.cmd("vertical resize " .. terminal_width)
      opposite_pos = "h"
    elseif pos == "J" then
      vim.cmd("resize " .. terminal_height)
      opposite_pos = "k"
    elseif pos == "K" then
      vim.cmd("resize " .. terminal_height)
      opposite_pos = "j"
    else
      print("Invalid input for pos: " .. pos)
      return
    end

    replid = vim.fn.termopen(cmd)

    if replid == nil then
      print("Failed to open terminal for REPL")
      return
    end

    print("replid: " .. replid)


    vim.cmd("wincmd " .. opposite_pos)
    vim.cmd("let b:slime_config = {\"jobid\": " .. replid .. "}")

    if vim.b.slime_config then
      print("Slime configured successfully")
    else
      print("Failed to configure Slime")
    end

    vim.cmd("set syntax=ocaml")
  end
  local wk = require("which-key")

  vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "ocaml"},
    callback = function()
      wk.add({
        { "<localleader>r", group = "Ocaml REPL" },
        { "<localleader>rr", OpenMLRepl, desc = "Open ML repl" },
        { "<localleader>ri", GetMlId, desc = "Get ML id" },
      })
    end,
  })
end

return M


