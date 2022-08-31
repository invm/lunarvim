local dap_status_ok, dap = pcall(require, "dap")
if not dap_status_ok then
    return
end

local dap_ui_status_ok, dapui = pcall(require, "dapui")
if not dap_ui_status_ok then
    return
end

local dap_install_status_ok, dap_install = pcall(require, "dap-install")
if not dap_install_status_ok then
    return
end

dap_install.setup {}

dap_install.config("python", {})
dap_install.config("jsnode", {})
-- add other configs here

dap.configurations.javascript = {{
    name = 'Launch',
    type = 'node2',
    request = 'launch',
    program = '${file}',
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = 'inspector',
    console = 'integratedTerminal'
}, {
    -- For this to work you need to make sure the node process is started with the `--inspect` flag.
    name = 'Attach to process',
    type = 'node2',
    request = 'attach',
    processId = require'dap.utils'.pick_process,
    port = 5959
}, {
    -- For this to work you need to make sure the node process is started with the `--inspect` flag.
    name = 'Attach to remote',
    type = 'node2',
    request = 'attach',
    restart = true,
    address = 'localhost',
    port = 5959,
    localRoot = '${workspaceFolder}',
    continueOnAttach = true,
    remoteRoot = '/app',
    skipFile = {'<node_internals>/**'}
}}

dapui.setup {
    layouts = {{
        elements = {'scopes', 'breakpoints', 'stacks', 'watches'},
        size = 40,
        position = 'left'
    }, {
        elements = {'repl', 'console'},
        size = 10,
        position = 'bottom'
    }}
}

vim.fn.sign_define("DapBreakpoint", {
    text = "",
    texthl = "DiagnosticSignError",
    linehl = "",
    numhl = ""
})

dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
end

dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
end

dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
end
