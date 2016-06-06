require 'pathname'
require 'erb'
require ENV['TM_BUNDLE_SUPPORT'] + '/lib/mate/formatter/inspected_file.rb'
require ENV['TM_BUNDLE_SUPPORT'] + '/lib/mate/formatter/template_helpers.rb'
require ENV['TM_BUNDLE_SUPPORT'] + '/lib/mate/proxy.rb'

module Mate
  module Formatter
    # This is used to format the response from rubocop
    # This is heavily influenced by the json formatter
    class Base < Proxy.rubocop::Formatter::BaseFormatter
      include ERB::Util
      include TemplateHelpers
      attr_reader :files, :summary, :files

      def initialize(*args)
        super
        @files = []
        @summary = { offence_count: 0 }
      end

      def started(target_files)
        @summary[:target_file_count] = target_files.count
      end

      def file_finished(file, offences)
        @files << InspectedFile.new(file: file, offences: offences)
        @summary[:offence_count] += offences.count
      end

      def finished(inspected_files)
        @summary[:inspected_file_count] = inspected_files.count
        output.write render
      end

      def metadata
        {
          :'RuboCop version' => Proxy.rubocop::Version::STRING,
          :'Ruby engine'     => RUBY_ENGINE,
          :'Ruby version'    => RUBY_VERSION,
          :'Ruby patchlevel' => RUBY_PATCHLEVEL.to_s,
          :'Ruby platform'   => RUBY_PLATFORM
        }
      end

      def render
        ERB.new(File.read(template_path)).result(binding)
      end

      private

      def relative_path(path)
        Pathname.new(path).relative_path_from(Pathname.getwd).to_s
      end

      def template_path(path = 'result.erb')
        File.join(template_base_path, path)
      end

      def template_base_path
        File.join(ENV['TM_BUNDLE_SUPPORT'], 'templates')
      end
    end
  end
end
