require 'rubygems'
require ENV['TM_BUNDLE_SUPPORT'] + '/lib/mate/env.rb'

# Try to detect where rubocop is installed on the users system
# Attempts to load rubocop from the following locations
#
# * system path
# * project
# * embedded version
class Proxy
  include Mate::Env

  def self.run!(options)
    new(options).run!
  end

  def self.rubocop
    defined?(RuboCop) ? RuboCop : Rubocop
  end

  attr_accessor :options, :files, :which_rubocop

  def initialize(args)
    @options       = custom_formatter_options
    @files         = [args[:files]].flatten
    @which_rubocop = load_rubocop
  end

  def run!
    self.class.rubocop::CLI.new.run(runtime_options)
  end

  private

  def runtime_options
    options_to_a.concat(files)
  end

  def options_to_a
    options.each_pair.reduce([]) do |obj, key_value|
      obj << "--#{key_value[0]}"
      obj << key_value[1]
      obj
    end
  end

  def load_rubocop
    system_rubocop || project_rubocop || embedded_rubocop
  end

  def system_rubocop
    require 'rubocop'
    :system
    rescue LoadError
      false
  end

  def project_rubocop
    $LOAD_PATH << project_path unless $LOAD_PATH.member?(project_path)
    require 'rubocop'
    :project
    rescue LoadError
      false
  end

  def embedded_rubocop
    ENV['GEM_HOME'] = vendor_path
    Gem.clear_paths

    require 'rubocop'
    :embedded
  end

  def custom_formatter_options
    {
      require: File.expand_path(ENV['TM_BUNDLE_SUPPORT'] + '/lib/mate/formatter/base.rb'),
      format: 'Mate::Formatter::Base'
    }
  end
end
