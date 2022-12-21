-- :luafile % で実行

print_table = function(t, head)
  if type(t) ~= 'table' then
    return
  end

  for key, val in pairs(t) do
    if type(val) ~= 'table' then
      print(head, key, ':', val)
    else
      print(head, key, ':')
      print_table(val, head..'    ')
    end
  end
end

print_table(vim.opt.lines, ' >')
-- print('column : ' .. vim.o.columns .. ', line : ' .. vim.opt.lines['_value'])

-- print(vim.o.cmdheight)

-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- print_table(capabilities.textDocument,' >')

-- local completion = vim.lsp.buf_request(0,'textDocument/completion')
-- print_table(completion,'')

