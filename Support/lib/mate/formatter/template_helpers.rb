# encoding: UTF-8
require 'pathname'
require ENV['TM_BUNDLE_SUPPORT'] + '/lib/mate/env.rb'

module Mate
  module Formatter
    module TemplateHelpers
      module InstanceMethods
        
        include Mate::Env
        
        def url_to(file, line=nil)
          out = "txmt://open?url=file://#{File.expand_path(file.path)}"
          line ? "#{out}&line=#{line}" : out
        end
        
        def fixed_class(val)
          val ? 'fixed' : 'not_fixed'
        end
        
        
        def fixed_message(val)
          "This has #{val ? 'has' : 'has not'} been fixed automatically"
        end

        # Remove the project
        def filename(file)
          file.path.sub(project_path,'')
        end
        
      end
      
      def self.included(receiver)
        receiver.send :include, InstanceMethods
      end
    end
  end
end