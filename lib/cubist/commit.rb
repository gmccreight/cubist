module Cubist

  class Commit
    require 'set'

    attr_reader :sha, :files

    def initialize(sha:, files:)
      @sha = sha
      @files = Set.new(files)
    end

    def contains_file?(file)
      @files.include?(file)
    end

  end

end
