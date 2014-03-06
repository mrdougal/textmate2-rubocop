# Try to detect where rubocop is installed on the users system
# Attempts to load rubocop from the following locations
# 
# * system path
# * project
# * embedded version
require 'rubygems'
require ENV['TM_BUNDLE_SUPPORT'] + '/lib/mate/env.rb'

class Proxy
  include Mate::Env
  
  def self.run!(options)
    self.new(options).run!
  end
  
  attr_accessor :options, :files, :which_rubocop

  def initialize(args)
    @options       = args[:options]
    @files         = [args[:files]].flatten
    @which_rubocop = load_rubocop
  end
  
  def run!
    Rubocop::CLI.new.run(runtime_options)
    # runtime_options
    # files
  end

  private

  def runtime_options
    # options_to_a
    # files
    options_to_a.concat(files)
  end
  
  def options_to_a
    options.each_pair.inject([]) do |obj, key_value|
      obj << "--#{key_value[0]}"
      obj << key_value[1]
      obj
    end
  end

  def load_rubocop
    system_rubocop || project_rubocop || embedded_rubocop
  end
  
  def system_rubocop
    begin
      require 'rubocop'
      :system
    rescue LoadError
      false
    end
  end
  
  def project_rubocop
    begin
      $: << project_path unless $:.member?(project_path)
      require 'rubocop'
      :project
    rescue LoadError
      false
    end
  end
  
  def embedded_rubocop
    ENV['GEM_HOME'] = vendor_path
    Gem.clear_paths 

    require 'rubocop'
    :embedded
  end     
          
end