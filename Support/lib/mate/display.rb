require 'json'
require 'erb'

module Mate
  class Display
    
    include ERB::Util
    attr_accessor :results

    def initialize(args)
      @results = args[:json]
    end
    
    def render
      ERB.new(File.read(template_path)).result(binding)
    end
    
    private
    
    def template_path
      File.join(ENV['TM_BUNDLE_SUPPORT'], '/templates/result.erb')
    end

  end  
end
