local status_ok, dap = pcall(require, 'dap')
if not status_ok then
  return
end

local status_ok, dap_utils = pcall(require, 'dap.utils')
if not status_ok then
  return
end

dap.adapters.node2 = {
  type = 'executable',
  command = 'node',
  args = {os.getenv('HOME') .. '/.config/vscode-node-debug2/out/src/nodeDebug.js'},
}

dap.configurations.javascript = {
  {
    name = 'Launch',
    type = 'node2',
    request = 'launch',
    program = '${file}',
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = 'inspector',
    console = 'integratedTerminal',
  },
  {
    name = 'Attach',
    type = 'node2',
    request = 'attach',
		skipFiles = { '<node_internals>/**' },
		port = 5959,
  },
	{
		name = 'Attach to Remote',
		type = 'node2',
		request = 'attach',
		restart = true,
		address = 'localhost',
		localRoot = '${workspaceFolder}',
		port = 5959,
		continueOnAttach = true,
		remoteRoot = '/app',
		skipFiles = { '<node_internals>/**' },
	},
}
