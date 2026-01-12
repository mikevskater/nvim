return {
  'mikevskater/sheet_todo',
  dependencies = {
      {'mikevskater/nvim-float', lazy = true},
  },
  name = 'sheet_todo',
  opts = {
      pantry_id = '0ffbc8bb-f7d7-41e6-ba77-6fbc75038813',
	    basket_name = 'sheet_todo',
  },
  cmd = {
    "TodoShow",
    "TodoSave",
    "TodoClose",
    "TodoStatus"
  },
  keys = {
    {
      "<leader>otd",
      "<cmd>TodoShow<cr>",
      desc = "Open Todo notepad"
    },
  },
  lazy = true,
}