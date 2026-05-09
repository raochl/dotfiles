local parsers = {
  'bash',
  'c',
  'cmake',
  'cpp',
  'css',
  'go',
  'html',
  'javascript',
  'json',
  'lua',
  'make',
  'markdown',
  'markdown_inline',
  'python',
  'rust',
  'sql',
  'terraform',
  'toml',
  'tsx',
  'typescript',
  'verilog',
  'vim',
  'vimdoc',
  'yaml',
}

local filetypes = {
  'bash',
  'c',
  'cmake',
  'cpp',
  'css',
  'go',
  'html',
  'javascript',
  'json',
  'lua',
  'make',
  'markdown',
  'python',
  'rust',
  'sh',
  'sql',
  'terraform',
  'toml',
  'typescript',
  'typescriptreact',
  'verilog',
  'vim',
  'vimdoc',
  'yaml',
}

return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = function()
    if vim.fn.executable 'tree-sitter' == 1 then
      require('nvim-treesitter').install(parsers):wait(300000)
    end
  end,
  config = function()
    require('nvim-treesitter').setup {
      install_dir = vim.fn.stdpath 'data' .. '/site',
    }

    vim.filetype.add {
      extension = {
        sv = 'verilog',
        svh = 'verilog',
        tf = 'terraform',
        tfvars = 'terraform',
      },
    }

    vim.api.nvim_create_autocmd('FileType', {
      pattern = filetypes,
      callback = function()
        pcall(vim.treesitter.start)
        pcall(function()
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end)
      end,
    })

    if vim.fn.executable 'tree-sitter' == 1 then
      require('nvim-treesitter').install(parsers)
    end
  end,
}
