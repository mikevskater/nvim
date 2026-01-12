return {
  --dir = "E:/nvim/plugin_dev/nvim-favdir"
  "mikevskater/nvim-favdir",
  dependencies = {
    {'mikevskater/nvim-float', lazy = true},
  },
  name = "nvim-favdir",
  cmd = {
    "FavdirOpen",
    "FavdirToggle",
    "FavdirAddDir",
    "FavdirAddFile",
    "FavdirSandbox"
  },
  keys = {
    {
      "<leader>ofd",
      "<cmd>FavdirOpen<cr>",
      desc = "Open Favorite Directories"
    },
  },
  opts = {},
  lazy = true,
}   