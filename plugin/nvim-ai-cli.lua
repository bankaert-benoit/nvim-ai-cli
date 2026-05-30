if vim.g.loaded_nvim_ai_cli then
  return
end
vim.g.loaded_nvim_ai_cli = true

vim.api.nvim_create_user_command("AiCli", function()
  require("nvim-ai-cli").toggle()
end, {})
