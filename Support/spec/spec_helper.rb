
# Stubs for TextMate env
ENV['TM_PROJECT_DIRECTORY'] ||= '.'
ENV['TM_BUNDLE_SUPPORT']    ||= File.dirname('..')

$: << '../lib'

# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.order = 'random'
end

def tm_selected_files(*files)
  ENV['TM_SELECTED_FILES'] = files.each.collect do |f|
                              "'#{File.absolute_path(f)}'"
                            end.join(' ')
end

require 'mate/runner'
