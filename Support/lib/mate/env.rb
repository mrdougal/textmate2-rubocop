module Mate
  module Env
    module InstanceMethods
      
      def project_path
        File.expand_path(ENV['TM_PROJECT_DIRECTORY']) rescue File.dirname(single_file)
      end
      
      def vendor_path
        File.expand_path(ENV['TM_BUNDLE_SUPPORT'] + '/vendor')
      end

      def multiple_files
        ENV['TM_SELECTED_FILES'].scan(/'(.*?)'/).flatten.map do |path|
          File.expand_path(path)
        end
      end
  
      def single_file
        File.expand_path(ENV['TM_FILEPATH'])
      end
      
    end
    
    def self.included(receiver)
      receiver.send :include, InstanceMethods
    end
  end
end