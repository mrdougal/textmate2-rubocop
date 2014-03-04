require ENV['TM_BUNDLE_SUPPORT'] + '/lib/mate/display.rb'
require ENV['TM_BUNDLE_SUPPORT'] + '/lib/mate/proxy.rb'

module Mate
  class Runner
    
    attr_accessor :options
    
    def initialize(args={})
      @options = args.merge :format => :json
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
      Dir.chdir(project_directory) do
        Proxy.run!(:options => options_to_s, :files => f)
      end
    end
    
    def options_to_s
      options.each_pair.collect do |key, value|
        "--#{key} #{value}"
      end
    end
    
    def project_directory
      File.expand_path(ENV['TM_PROJECT_DIRECTORY']) rescue File.dirname(single_file)
    end

    def multiple_files
      ENV['TM_SELECTED_FILES'].scan(/'(.*?)'/).flatten.collect do |path|
        File.expand_path(path)
      end
    end
    
    def single_file
      File.expand_path(ENV['TM_FILEPATH'])
    end

  end  
end
