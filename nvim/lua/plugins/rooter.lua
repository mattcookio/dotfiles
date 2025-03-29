return {
  {
    'airblade/vim-rooter',
    config = function()
      vim.g.rooter_patterns = { '.git', 'package.json', 'Cargo.toml', 'pyproject.toml', 'setup.py',
        'requirements.txt' }
      vim.g.rooter_silent_chdir = 1
      vim.g.rooter_resolve_symlinks = 1
    end,
  }
}
