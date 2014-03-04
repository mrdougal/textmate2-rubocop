# Try to detect where rubocop is installed on the users system
# (this needs work)

# require 'rubocop'

class Proxy
  
  def self.run!(options)
    self.new(options).run!
  end
  
  attr_accessor :options, :files

  def initialize(args)
    options = args[:options]
    files   = args[:files]
  end
  
  def run!
    # Rubocop::CLI.new.run(runtime_options)
  end

  private

  def runtime_options
    [options, files].join(' ')
  end
  
end