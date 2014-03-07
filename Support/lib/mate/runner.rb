require ENV['TM_BUNDLE_SUPPORT'] + '/lib/mate/env.rb'
require ENV['TM_BUNDLE_SUPPORT'] + '/lib/mate/proxy.rb'

module Mate
  # Called directly by the scripts in bin, and calls the rubocop proxy
  # which will run the analysis
  class Runner
    include Mate::Env
    attr_accessor :options

    def current_file
      run(single_file)
    end

    def selected_files
      run(multiple_files)
    end

    private

    def run(f)
      Dir.chdir(project_path) do
        Proxy.run!(files: f)
      end
    end
  end
end
