-- General settings
vim.opt.number = true
vim.opt.swapfile = false
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.clipboard:append("unnamedplus")
vim.opt.smartindent = true
vim.opt.synmaxcol = 1000
vim.cmd("colorscheme koehler")

-- Tab settings for specific file types
vim.api.nvim_create_augroup("fileTypeIndent", { clear = true })

local indent_2_file_types = {
    "*.yml", "*.yaml", "*.html", "*.rb", "*.css", "*.sh", "*.xacro",
    "*.xml", "*.sdf", "*.world", "*.launch", "*.vue", "*.urdf", "*.dart",
    "*.ts", "*.tsx", "*.cc", "*.js", "*.json", "*.test", "*.proto", "*.lua"
}

for _, ft in ipairs(indent_2_file_types) do
    vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
        pattern = ft,
        group = "fileTypeIndent",
        command = "setlocal tabstop=2 softtabstop=2 shiftwidth=2"
    })
end

-- Key mappings
vim.g.mapleader = " "

vim.keymap.set("n", "<Leader>w", "[window]")
vim.keymap.set("n", "[window]h", "<C-w>h")
vim.keymap.set("n", "[window]j", "<C-w>j")
vim.keymap.set("n", "[window]k", "<C-w>k")
vim.keymap.set("n", "[window]l", "<C-w>l")

vim.keymap.set("n", "<C-c><C-c>", ":nohlsearch<CR>", { silent = true })
vim.keymap.set("n", "<CR>", "A<CR><ESC>", { silent = true })

-- Syntax settings
vim.g.cpp_no_function_highlight = 1
vim.g.cpp_no_variable_highlight = 1
vim.g.cpp_simple_highlight = 1
vim.g.cpp_named_requirements_highlight = 1
