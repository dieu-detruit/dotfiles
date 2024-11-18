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

local function clang_format_in_place()
    -- ファイルパスを取得
    local filepath = vim.fn.expand('%:p')

    -- ファイルを保存
    vim.cmd('write')

    -- clang-format -i を適用
    local result = vim.fn.system('clang-format -i ' .. vim.fn.shellescape(filepath))

    -- エラーが発生した場合、通知
    if vim.v.shell_error ~= 0 then
        vim.notify('Error running clang-format: ' .. result, vim.log.levels.ERROR)
        return
    end

    -- フォーマット後の内容をバッファに再読み込み
    vim.cmd('edit!')
end

-- clang-formatが利用可能な場合、autocmdを設定
if vim.fn.executable('clang-format') == 1 then
    vim.api.nvim_create_augroup('cpp_clang_format', { clear = true })
    vim.api.nvim_create_autocmd(
        { 'BufWrite', 'FileWritePre', 'FileAppendPre' },
        {
            pattern = { '*.[ch]pp', '*.cc', '*.[ch]', '*.pde', '*.ino', '*.proto' },
            callback = clang_format_in_place,
            group = 'cpp_clang_format',
        }
    )
end
