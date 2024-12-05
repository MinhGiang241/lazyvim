local js_based_languages = {
  "typescript",
  "javascript",
  "typescriptreact",
  "javascriptreact",
  "vue",
}

return {
  "mfussenegger/nvim-dap",
  config = function()
    local dap = require("dap")
    local Config = require("lazyvim.config")
    vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

    for name, sign in pairs(Config.icons.dap) do
      sign = type(sign) == "table" and sign or { sign }
      vim.fn.sign_define(
        "Dap" .. name,
        { text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
      )
    end

    dap.adapters.coreclr = {
      type = "executable",
      command = "netcoredbg",
      args = { "--interpreter=vscode" },
    }

    dap.configurations.cs = {
      {
        type = "coreclr",
        name = "launch - netcoredbg",
        request = "launch",
        program = function()
          return vim.fn.input("Path to dll", vim.fn.getcwd() .. "/bin/Debug/", "file")
        end,
      },
    }

    for _, language in ipairs(js_based_languages) do
      dap.configurations[language] = {
        --Debug typescript
        {
          type = "pwa-node",
          request = "launch",
          name = "Typescript debug",
          skipFiles = {
            "<node_internals>/**",
          },
          args = { "${file}" },
          sourceMaps = true,
          protocol = "inspector",
          program = "${file}",
          preLaunchTask = "tsc: build - tsconfig.json",
          runtimeArgs = { "--nolazy", "-r", "ts-node/register", "-r", "tsconfig-paths/register" },
          cwd = "${workspaceFolder}",
        },
        {
          type = "pwa-node",
          request = "launch",
          name = "Debug TS ",
          program = "${workspaceFolder}/index.ts",
          cwd = "${workspaceFolder}",
          sourceMaps = true,
          protocol = "inspector",
          runtimeArgs = { "--nolazy", "-r", "ts-node/register", "-r", "tsconfig-paths/register" },
        },
        {
          type = "pwa-node",
          request = "launch",
          name = "Launch Current File (pwa-node with ts-node)",
          cwd = vim.fn.getcwd(),
          runtimeArgs = { "--loader", "ts-node/esm", "--no-warnings" },
          runtimeExecutable = "node",
          args = { "${file}" },
          sourceMaps = true,
          protocol = "inspector",
          skipFiles = { "<node_internals>/**", "node_modules/**" },
          resolveSourceMapLocations = {
            "${workspaceFolder}/**",
            "!**/node_modules/**",
          },
        },
        {
          type = "pwa-chrome",
          request = "attach",
          name = "Attach Program (pwa-chrome = { port: 9222 })",
          program = "${file}",
          cwd = vim.fn.getcwd(),
          sourceMaps = true,
          port = 9222,
          webRoot = "${workspaceFolder}",
        },
        {
          type = "pwa-node",
          request = "launch",
          name = "Launch Current File (Typescript)",
          runtimeArgs = { "--loader", "ts-node/esm" },
          cwd = "${workspaceFolder}",
          -- runtimeArgs = { "--loader=ts-node/esm" },
          args = { "${file}" },
          runtimeExecutable = "node",
          -- args = { '${file}' },
          sourceMaps = true,
          protocol = "inspector",
          outFiles = { "${workspaceFolder}/**/**/*", "!**/node_modules/**" },
          skipFiles = { "<node_internals>/**", "node_modules/**" },
          resolveSourceMapLocations = {
            "${workspaceFolder}/**",
            "!**/node_modules/**",
          },
        },
        -- Debug Nestjs
        {
          type = "pwa-node",
          request = "launch",
          name = "Debug Nest Framework",
          program = "${workspaceFolder}/src/main.ts",
          cwd = "${workspaceFolder}",
          sourceMaps = true,
          protocol = "inspector",
          runtimeArgs = { "--nolazy", "-r", "ts-node/register", "-r", "tsconfig-paths/register" },
        },
        {
          type = "pwa-node",
          request = "launch",
          name = "Launch Current File (Typescript)",
          runtimeArgs = { "--loader", "ts-node/esm" },
          cwd = "${workspaceFolder}",
          -- runtimeArgs = { "--loader=ts-node/esm" },
          args = { "${file}" },
          runtimeExecutable = "node",
          -- args = { '${file}' },
          sourceMaps = true,
          protocol = "inspector",
          outFiles = { "${workspaceFolder}/**/**/*", "!**/node_modules/**" },
          skipFiles = { "<node_internals>/**", "node_modules/**" },
          resolveSourceMapLocations = {
            "${workspaceFolder}/**",
            "!**/node_modules/**",
          },
        },
        -- Debug signle nodejs file
        {
          type = "pwa-node",
          request = "launch",
          name = "Launch file",
          program = "${file}",
          cwd = "${workspaceFolder}",
          sourceMaps = true,
        },
        -- Debug nodejs processes (make sure to odd --inspect when you run the process)
        {
          type = "pwa-node",
          request = "attach",
          name = "Attach",
          processId = require("dap.utils").pick_process,
          cwd = "${workspaceFolder}",
          sourceMaps = true,
        },
        -- Debug web applications (client side)
        {
          type = "pwa-chrome",
          request = "launch",
          name = "Launch & Debug Chrome",
          url = function()
            local co = coroutine.running()
            return coroutine.create(function()
              vim.ui.input({
                prompt = "Enter URL: ",
                default = "http://localhost:3000",
              }, function(url)
                if url == nil or url == "" then
                  return
                else
                  coroutine.resume(co, url)
                end
              end)
            end)
          end,
          webRoot = "${workspaceFolder}",
          skipFiles = { "<node_internals>/**/*.js" },
          protocol = "inspector",
          sourceMaps = true,
          userDataDir = false,
        },
        -- Divider for the launch.json derived config
        {
          name = "------- ! launch.json config ! -------",
          type = "",
          request = "launch",
        },
        {
          name = "Next.js: debug server-side",
          type = "pwa-node",
          request = "launch",
          cwd = "${workspaceFolder}",
          runtimeExecutable = "npm",
          runtimeArgs = { "run-script", "dev" },
          sourceMaps = true,
        },
      }
    end
  end,
  keys = {
    {
      "<leader>dO",
      function()
        require("dap").step_out()
      end,
      desc = "Step Out",
    },
    {
      "<leader>do",
      function()
        require("dap").step_over()
      end,
      desc = "Step Over",
    },
    {
      "<leader>da",
      function()
        if vim.fn.filereadable(".vscode/launch.json") then
          local dap_vscode = require("dap.ext.vscode")
          dap_vscode.load_launchjs(nil, {
            ["pwa-node"] = js_based_languages,
            ["node"] = js_based_languages,
            ["chrome"] = js_based_languages,
            ["pwa-chrome"] = js_based_languages,
          })
        end
        require("dap").continue()
      end,
      desc = "Run with Args",
    },
  },
  dependencies = {
    -- Install the vscode-js-debug adapter
    {
      "microsoft/vscode-js-debug",
      -- After install, build it and rename the dist directory to out
      build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
    },
    {
      "mxsdev/nvim-dap-vscode-js",
      config = function()
        --@diagnostic disable-next-line: missing-fields
        require("dap-vscode-js").setup({
          -- Path of node executable , Default to $NODE_PATH, and then "node"
          -- node_path = "node"

          -- Path to vscode-js-debug installation
          debugger_path = vim.fn.resolve(vim.fn.stdpath("data") .. "/lazy/vscode-js-debug"),

          -- Command to use to launch the debug server. Takes precedence over "node_path" and "debugger_path"
          -- debugger_cmd = {"js-debug-adapter"},

          -- which adapters to register in nvim-dap
          adapters = {
            "chrome",
            "pwa-node",
            "pwa-chrome",
            "pwa-msedge",
            "pwa-extensionHost",
            "node-terminal",
            "node",
          },

          -- Path for file logging
          -- log_file_path = "(stdpath cache)/dap_vscode_js.log",
          -- Logging level for output to file. Set to false to disable loggeing
          -- log_file_level =  false
          -- Logging level for output to console. Set to false to disable consoleoutput,
          -- log_console_level = vim.log.levels.ERROR.
        })
      end,
    },
    {
      "Joakker/lua-json5",
      build = "./install.sh",
    },
  },
}
