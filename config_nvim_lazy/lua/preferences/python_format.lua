local function preserve(command)
    -- Save the last search.
    local search = vim.fn.getreg('/')
    -- Save the current cursor position.
    local cursor_position = vim.api.nvim_win_get_cursor(0)
    -- Save the current window position.
    vim.cmd('normal! H')
    local window_position = vim.api.nvim_win_get_cursor(0)
    vim.api.nvim_win_set_cursor(0, cursor_position)
    
    -- Execute the command.
    vim.cmd(command)
    
    -- Restore the last search.
    vim.fn.setreg('/', search)
    -- Restore the previous window position.
    vim.api.nvim_win_set_cursor(0, window_position)
    vim.cmd('normal! zt')
    -- Restore the previous cursor position.
    vim.api.nvim_win_set_cursor(0, cursor_position)
end

local function black()
    preserve('silent %!black -')
end

-- 保存時に自動修正
group = vim.api.nvim_create_augroup("BlackGroup", {})
vim.api.nvim_create_autocmd({"BufWritePre", "FileWritePre", "FileAppendPre"}, {
    pattern = "*.py",
    callback = black,
    group = group
})
