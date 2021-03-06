require 'sprockets'
require 'sprockets-helpers'
require 'construct'
require 'pathname'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  config.include Construct::Helpers
  
  # Returns a Sprockets environment. Automatically
  # appends the 'assets' path if available.
  def env
    @env ||= Sprockets::Environment.new.tap do |env|
      env.append_path 'assets' if File.directory?('assets')
    end
  end
  
  # Returns a fresh context, that can be used to test helpers.
  def context(logical_path = 'application.js', pathname = nil)
    pathname ||= Pathname.new(File.join('assets', logical_path)).expand_path
    env.context_class.new env, logical_path, pathname
  end
end
