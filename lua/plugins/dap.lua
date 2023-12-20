-- nvim dap
local dap = require("dap")
dap.set_log_level("TRACE")
dap.adapters.coreclr = {
  type = "executable",
  command = "C:/Users/minhg/scoop/apps/netcoredbg/3.0.0-1018/netcoredbg",
  -- command = "C:/Users/minhg/AppData/Local/nvim-data/mason/packages/netcoredbg/netcoredbg/netcoredbg.exe",
  args = { "--interpreter=vscode" },
}
dap.configurations.cs = {
  {

    type = "coreclr",
    name = "launch - netcoredbg",
    request = "launch",
    program = function()
      dap.set_log_level("TRACE")
      return vim.fn.input("Path to dll", vim.fn.getcwd() .. "/bin/Debug/", "file")
    end,
  },
  {
    type = "coreclr",
    name = "attach - netcoredbg",
    request = "attach",
    processId = require("dap.utils").pick_process,
  },
}

return {}
