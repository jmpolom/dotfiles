local path_package = vim.fs.joinpath(vim.fn.stdpath('data'),'/site/')
-- vim.print(path_package)
local mini_path = vim.fs.joinpath(path_package,'pack/deps/start/mini.deps')
-- vim.print(mini_path)
if not vim.uv.fs_stat(mini_path) then
  vim.print("Installing `mini.deps`")
  local clone_cmd = {
    'git', 'clone', '--filter=blob:none',
    'https://github.com/echasnovski/mini.deps.git', mini_path
  }
  vim.system(clone_cmd):wait()
  vim.cmd('packadd mini.deps | helptags ALL')
  vim.print("Installed `mini.deps`")
end

-- Set up 'mini.deps' (customize to your liking)
require('mini.deps').setup({ path = { package = path_package } })
