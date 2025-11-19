return {
  {
    'KeitaNakamura/tex-conceal.vim',
    ft = { 'tex' }, -- load only for TeX files
    config = function()
      vim.opt.conceallevel = 1
      vim.g.tex_conceal = 'abdmg'
      vim.cmd 'hi Conceal ctermbg=none'
    end,
  },
}
