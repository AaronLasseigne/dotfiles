return {
  filetypes = { 'ruby' },

  cmd = { 'ruby-lsp' },

  root_markers = { 'Gemfile', '.git' },

  init_options = {
    formatter = 'rubocop',
    linters = { 'rubocop' },
    addonSettings = {
      ['Ruby LSP Rails'] = {
        enablePendingMigrationsPrompt = false,
      }
    }
  }
}
