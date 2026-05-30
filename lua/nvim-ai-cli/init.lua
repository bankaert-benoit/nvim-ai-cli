local config = require("nvim-ai-cli.config")

local M = {}

M.bufnr = nil

function M.setup(opts)
  config.merge(opts)
end

local function window_side()
  if config.values.side == "left" then
    return "topleft vsplit"
  end
  return "botright vsplit"
end

local function compute_width()
  local total = vim.o.columns
  local pct = config.values.width / 100
  return math.floor(total * pct)
end

local function close_window()
  if not M.bufnr then
    return
  end
  local winid = vim.fn.bufwinnr(M.bufnr)
  if winid > 0 then
    vim.api.nvim_win_close(winid, true)
  end
end

function M.open()
  if not config.values.cmd then
    vim.notify("nvim-ai-cli: 'cmd' option is not set", vim.log.levels.ERROR)
    return
  end

  close_window()

  local width = compute_width()

  vim.cmd(window_side())
  vim.cmd("vertical resize " .. width)

  local bufnr = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_win_set_buf(0, bufnr)

  local cmd = config.values.cmd
  if type(cmd) == "string" then
    cmd = vim.split(cmd, "%s+")
  end

  local job_id = vim.fn.termopen(cmd, {
    on_exit = function()
      M.bufnr = nil
    end,
  })

  if job_id <= 0 then
    vim.notify("nvim-ai-cli: failed to start '" .. config.values.cmd .. "'", vim.log.levels.ERROR)
    return
  end

  M.bufnr = bufnr

  vim.bo[bufnr].bufhidden = "hide"
  vim.bo[bufnr].buflisted = false
  vim.bo[bufnr].filetype = "nvim-ai-cli"

  vim.cmd("startinsert")
end

function M.close()
  close_window()
  M.bufnr = nil
end

function M.toggle()
  if M.bufnr and vim.fn.bufwinnr(M.bufnr) > 0 then
    M.close()
  else
    M.open()
  end
end

return M
