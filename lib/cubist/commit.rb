module Cubist

  class Commit
    require 'set'

    def initialize(files:)
      @files = Set.new(files)
    end

    def files
      @files
    end

    def contains_file?(file)
      @files.include?(file)
    end

  end

end
