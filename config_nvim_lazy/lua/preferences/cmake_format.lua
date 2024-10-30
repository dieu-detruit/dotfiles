-- Save and restore cursor, window, and search positions while executing a command
local function preserve(command)
    local search = vim.fn.getreg('/')
    local cursor_position = vim.api.nvim_win_get_cursor(0)
    vim.cmd('normal! H')
    local window_position = vim.api.nvim_win_get_cursor(0)
    vim.api.nvim_win_set_cursor(0, cursor_position)
    vim.cmd(command)
    vim.fn.setreg('/', search)
    vim.api.nvim_win_set_cursor(0, window_position)
    vim.cmd('normal! zt')
    vim.api.nvim_win_set_cursor(0, cursor_position)
end

-- cmake-format function
local function cmake_format()
    preserve('silent %!cmake-format -')
end

-- Setup auto commands if cmake-format is available
if vim.fn.executable('cmake-format') == 1 then
    vim.api.nvim_create_augroup('cmake_format', { clear = true })
    vim.api.nvim_create_autocmd(
        { 'BufWrite', 'FileWritePre', 'FileAppendPre' },
        {
            pattern = 'CMakeLists.txt',
            callback = cmake_format,
            group = 'cmake_format'
        }
    )
end
