# encoding: UTF-8
require 'pathname'
require ENV['TM_BUNDLE_SUPPORT'] + '/lib/mate/env.rb'

module Mate
  module Formatter
    # Helpers for use in the template/erb views
    module TemplateHelpers
      module InstanceMethods
        include Mate::Env
        
        def url_to(file, line = nil)
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
          file.path.sub(project_path, '')
        end
        
        def offences_message
          case @summary[:offence_count]
          when 0
            'No offences'
          when 1
            'Only 1 offence'
          else
            "#{@summary[:offence_count]} offences"
          end
        end
        
        def file_count
          @files.length > 1 ? "#{@files.length} files" : '1 file'
        end
        
        def partial(file, options = {})
          f = options[:f]
          ERB.new(File.read(template_path(file))).result(binding)
        end
      end
      
      def self.included(receiver)
        receiver.send :include, InstanceMethods
      end
    end
  end
end
