return {
  --dir = "E:/nvim/plugin_dev/nvim-favdir", 
  "mikevskater/nvim-favdir",
  dependencies = {
    {'mikevskater/nvim-float', lazy = true},
    {'mikevskater/nvim-colorpicker', lazy = true},
  },
  name = "nvim-favdir",
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