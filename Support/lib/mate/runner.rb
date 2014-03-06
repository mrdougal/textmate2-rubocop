require ENV['TM_BUNDLE_SUPPORT'] + '/lib/mate/env.rb'
require ENV['TM_BUNDLE_SUPPORT'] + '/lib/mate/display.rb'
require ENV['TM_BUNDLE_SUPPORT'] + '/lib/mate/proxy.rb'

module Mate
  class Runner
    
    include Mate::Env
    attr_accessor :options
    
    def initialize(args={})
      @options = args.merge :format => ['simple']
    end

    def run_file
      render(single_file)
    end

    def run_files
      render(multiple_files)
    end

    private

    def render(files)
      puts Display.new(:json => run(files)).render
    end
    
    def run(f)
      Dir.chdir(project_path) do
        Proxy.run!(:options => options, :files => f)
      end
    end
    
  end
end
