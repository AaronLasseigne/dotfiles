return {
  filetypes = { 'ruby' },

  -- Launch through mise so ruby-lsp always runs under the project's pinned
  -- Ruby (per .tool-versions), regardless of which Ruby was active in PATH
  -- when nvim started. Avoids Bundler::RubyVersionMismatch on the composed bundle.
  cmd = { 'mise', 'exec', '--', 'ruby-lsp' },

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
