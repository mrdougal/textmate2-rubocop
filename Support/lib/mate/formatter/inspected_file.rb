module Mate
  module Formatter
    # Helper class - representing the inspected file
    # most of the hard work as been done
    class InspectedFile
      attr_accessor :path, :offences
      def initialize(args)
        @path     = args[:file]

        # Attributes of an offence
        # * severity
        # * message
        # * cop_name
        # * corrected?
        # * line
        # * real_column
        @offences = args[:offences]
      end
    end
  end
end
