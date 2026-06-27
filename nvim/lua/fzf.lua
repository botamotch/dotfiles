local M = {
  nb_title_cache = {}
}

function M.files()
  require('fzf-lua').files({ fzf_opts = {
    ["--header"] = "Enter:open  Ctrl-S:split  Ctrl-V:v-split",
  }})
end

function M.git_status()
  require('fzf-lua').git_status()
end

function M.buffers()
  require('fzf-lua').buffers()
end

function M.grep()
  require('fzf-lua').grep()
end

function M.blines()
  require('fzf-lua').blines()
end

function M.nb_picker()
  local fzf = require('fzf-lua')
  fzf.fzf_exec('nb ls --no-header --no-footer 2>/dev/null', {
    prompt  = 'nb> ',
    preview =
    "id=$(echo {} | grep -oE '^\\[([^]]+)\\]' | tr -d '[]'); nb show \"$id\" --print 2>/dev/null",
    winopts = { preview = { layout = 'horizontal', vertical = 'flex' } },
    fzf_opts = {
      ["--header"] = "Enter:open  Ctrl-V:open v-split  Ctrl-N:add  Ctrl-D:delete  Ctrl-P:pin",
    },
    actions = {
      -- Enter: ノートのファイルをバッファで開く
      ['default'] = function(selected)
        if not selected or not selected[1] then return end
        local id = selected[1]:match('^%[([^%]]+)%]')
        if not id then return end
        local path = vim.fn.system('nb show ' .. vim.fn.shellescape(id) .. ' --path'):gsub('\n', '')
        if path and path ~= '' then
          vim.cmd('edit ' .. vim.fn.fnameescape(path))
        end
      end,
      -- Ctrl-V: 垂直分割で開く
      ['ctrl-v'] = function(selected)
        if not selected or not selected[1] then return end
        local id = selected[1]:match('^%[([^%]]+)%]')
        if not id then return end
        local path = vim.fn.system('nb show ' .. vim.fn.shellescape(id) .. ' --path'):gsub('\n', '')
        if path and path ~= '' then
          vim.cmd('vsplit ' .. vim.fn.fnameescape(path))
        end
      end,
      -- Ctrl-N: 新規ノートを作成
      ['ctrl-n'] = function()
        vim.cmd('new')
        vim.fn.termopen({ 'nb', 'add', '# <untitled>' })
      end,
      -- Ctrl-D: 選択したノートを削除
      ['ctrl-d'] = function(selected)
        if not selected or not selected[1] then return end
        local id = selected[1]:match('^%[([^%]]+)%]')
        if not id then return end
        vim.cmd('terminal nb delete ' .. id)
      end,
      ['ctrl-p'] = function()
        vim.cmd("echo 'TODO pin note'")
      end,
    },
  })
end

-- NOTE fzfではない。まぁええか
function M.nb_get_title(filepath)
  if not filepath:match("^" .. vim.fn.expand("~/.nb")) then
    return nil
  end
  if M.nb_title_cache[filepath] ~= nil then
    return M.nb_title_cache[filepath]
  end
  local result = vim.system({"nb", "show", filepath, "--title"}, { text = true }):wait()
  local title = (result.code == 0) and vim.split(result.stdout, "\n")[1] or false
  M.nb_title_cache[filepath] = title
  return title or nil
end

return M
