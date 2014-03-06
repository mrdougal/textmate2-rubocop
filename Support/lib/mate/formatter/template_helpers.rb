# encoding: UTF-8
require 'pathname'
require ENV['TM_BUNDLE_SUPPORT'] + '/lib/mate/env.rb'

module Mate
  module Formatter
    # Helpers for use in the template/erb views
    module TemplateHelpers
      module InstanceMethods
        include Mate::Env
        
        def url_to(file, line = nil, column = nil)
          # for reference 
          # http://blog.macromates.com/2007/the-textmate-url-scheme/
          out = "txmt://open?url=file://#{File.expand_path(file.path)}"
          out += "&line=#{line}" if line
          out += "&column=#{column}" if column
          out
        end
        
        def fixed_class(val)
          val ? 'fixed' : 'not_fixed'
        end
        
        def fixed_message(val)
          "This has #{val ? 'has' : 'has not'} been fixed automatically"
        end
        
        def class_for_issue(issue)
          ['wrapper', issue.severity, fixed_class(issue.corrected?)].join(' ')
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
          # rubocop considers the next line 'useless', 
          # but is used by erb with it's binding
          # i'm' not sure how else to implement it
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
