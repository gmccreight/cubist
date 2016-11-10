require 'logger'

module Cubist

  class Logger < ::Logger

    def self.instance(pipe = STDOUT)
      @logger ||= new(pipe)
    end

    def initialize(pipe, *args)
      super(pipe, *args)
      self.level = WARN
      self.formatter = method(:format_log)
    end

    def enter_level(new_level = level, &block)
      old_level, self.level = level, new_level
      yield
    ensure
      self.level = old_level
    end

    private

    # Log format (from Logger implementation). Used by Logger internally
    def format_log(sev, time, prog, msg)
      "[#{sev.downcase}]: #{msg}\n"
    end

  end

end
