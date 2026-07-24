ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../Gemfile', __dir__)

require "bundler/setup" # Set up gems listed in the Gemfile.
require "logger"
require "ostruct"
require "yaml"
require "psych"

module YAML
  class << self
    def load_file(filepath, *args, **kwargs)
      kwargs[:aliases] = true unless kwargs.key?(:aliases)
      if respond_to?(:unsafe_load_file)
        unsafe_load_file(filepath, **kwargs)
      else
        super
      end
    rescue StandardError
      unsafe_load_file(filepath)
    end

    def load(yaml, *args, **kwargs)
      if respond_to?(:unsafe_load)
        unsafe_load(yaml)
      else
        super
      end
    end
  end
end

module Psych
  class << self
    def load_file(filepath, *args, **kwargs)
      kwargs[:aliases] = true unless kwargs.key?(:aliases)
      if respond_to?(:unsafe_load_file)
        unsafe_load_file(filepath, **kwargs)
      else
        super
      end
    rescue StandardError
      unsafe_load_file(filepath)
    end
  end
end
# require "bootsnap/setup" # Speed up boot time by caching expensive operations.




