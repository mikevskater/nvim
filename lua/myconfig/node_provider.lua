-- Configure Node.js provider for remote plugins
-- This ensures Neovim can find node and the neovim package

-- Set the node host program to the global neovim CLI
vim.g.node_host_prog = vim.fn.expand('$APPDATA') .. '/npm/node_modules/neovim/bin/cli.js'

-- Enable debug logging for node host
vim.env.NVIM_NODE_LOG_FILE = vim.fn.expand('$TEMP') .. '/nvim_node.log'
vim.env.NVIM_NODE_LOG_LEVEL = 'debug'
