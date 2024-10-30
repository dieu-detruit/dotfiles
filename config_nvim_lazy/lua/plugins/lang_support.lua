return {
	-- toml
	{	
		"cespare/vim-toml",
		ft = "toml",
	},

	--  Rust
	{
		"rust-lang/rust.vim",
		ft = "rust",
		config = function()
			vim.g.rustfmt_autosave = 1
		end,
	},

	--  Haskell
	{
		"alx741/vim-stylishask",
		ft = "haskell",
	},

	--  Typescript
	{
		"leafgarland/typescript-vim",
		ft = "typescript",
	},

	--  TSX
	{
		"tasn/vim-tsx",
		ft = "typescriptreact",
	}
}
