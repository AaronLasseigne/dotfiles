Pry.config.editor = ENV['EDITOR']

# Load plugins (only those I whitelist)
Pry.config.should_load_plugins = true
# Pry.plugins["doc"].activate!

# Launch Pry with access to the entire Rails stack.
# If you have Pry in your Gemfile, you can pass: ./script/console --irb=pry instead.
# If you don't, you can load it through the lines below :)
rails = File.join Dir.getwd, 'config', 'environment.rb'

if File.exist?(rails) && ENV['SKIP_RAILS'].nil?
  require rails
end

if defined?(Rails) && Rails.env
  extend Rails::ConsoleMethods
end
