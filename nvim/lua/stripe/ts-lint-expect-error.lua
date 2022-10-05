local M = {}

M.findTsExpectErrors = function(folderPath)
  local fullPath = vim.fn.fnamemodify(folderPath, ":p:h")

  print("generating errors, hold please...")

  local binary = os.getenv('HOME') .. "/stripe/ts-lint-expect-error/bin/lint"
  local stdout = vim.fn.system({ binary, '--vim', fullPath })

  local lines = vim.split(stdout, "\n", { plain = true, trimempty = true })
  local quickfixList = vim.fn.getqflist({
    efm = "%f:%l:%c:%m",
    lines = lines
  })

  local items = quickfixList.items

  if #items > 0 then
    vim.fn.setqflist(items, 'r')
    vim.cmd("copen")

    -- clear input
    vim.fn.feedkeys(':','nx')
  else
    print("No errors found!")
  end
end

return M
