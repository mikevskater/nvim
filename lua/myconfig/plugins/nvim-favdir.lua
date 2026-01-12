return {
    --dir = "E:/nvim/plugin_dev/nvim-favdir"
    "mikevskater/nvim-favdir",
    opts = {},
    cmd = { "FavdirOpen", "FavdirToggle", "FavdirAddDir", "FavdirAddFile", "FavdirSandbox" },
    keys = {
      { "<leader>ofd", "<cmd>FavdirOpen<cr>", desc = "Open Favorite Directories" },
    },
}   