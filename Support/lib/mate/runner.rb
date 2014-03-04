# require 'rubocop'
require ENV['TM_BUNDLE_SUPPORT'] + '/lib/mate/display.rb'


module Mate
  class Runner
    
    attr_accessor :options
    
    def initialize(args={})
      @options = args.merge :format => :json
    end

    def run_file
      # puts run!
      puts Display.new(:json => run!).render
    end
    
    private
    
    def run!
      
      # output = ''
      Dir.chdir(project_directory) do
        
        '{"name":"dougal"}'
        # Rubocop::CLI.new.run([options_to_s, files].join(' '))
      end
      
      # output
    end
    
    def options_to_s
      options.each_pair.collect do |key, value|
        "--#{key} #{value}"
      end
    end
    
    def files
      ENV['TM_SELECTED_FILES'].scan(/'(.*?)'/).flatten.collect do |path|
        File.expand_path(path)
      end
    end
    
    def project_directory
      File.expand_path(ENV['TM_PROJECT_DIRECTORY']) rescue File.dirname(single_file)
    end

    def single_file
      File.expand_path(ENV['TM_FILEPATH'])
    end

  end  
end
