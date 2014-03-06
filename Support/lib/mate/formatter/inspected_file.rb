module Mate
  module Formatter
    class InspectedFile
      
      attr_accessor :path, :offences
      
      def initialize(args)
        @path     = args[:file]
        
        # severity
        # message
        # cop_name
        
        # corrected?
        # line
        # real_column
        @offences = args[:offences]
      end
      
      def name
        @path
      end
      
      def url(offence)
        "txt:#{@path}"
      end

    end
  end
end