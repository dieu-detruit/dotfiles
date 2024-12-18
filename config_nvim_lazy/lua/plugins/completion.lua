return {
	---- completion
  {
    "Shougo/ddc.vim",
    dependencies = {
      "vim-denops/denops.vim",
      "Shougo/ddc-ui-native",
      "Shougo/ddc-source-around",
      "LumaKernel/ddc-source-file",
      "Shougo/ddc-matcher_head",
      "Shougo/ddc-sorter_rank",
    },
    config = function()
      vim.fn["ddc#custom#patch_global"]({
        ui = "native",
        sources = { "around", "file" },
        sourceOptions = {
          _ = {
            matchers = { "matcher_head" },
            sorters = { "sorter_rank" },
          },
          around = {
            mark = "A",
          },
          file = {
            mark = "F",
            isVolatile = true,
            forceCompletionPattern = "\\S/\\S*",
          },
        },
        sourceParams = {
          around = {
            maxSize = 500,
          },
        },
      })

      vim.fn["ddc#enable"]()
    end
  },
}
