require 'find'
require 'fileutils'

module Cubist

  class SourceFilesFinder

    def initialize(root:)
      @root = root
    end

    def run
      get_files(@root)
    end

    private def get_files(dir)
      results = []
      Find.find(dir) do |path|
        if FileTest.directory?(path)
          if File.basename(path)[0] == ?. and File.basename(path) != '.'
            Find.prune
          else
            next
          end
        else
          if File.basename(path) != ".DS_Store"
            results << path
          end
        end
      end
      results
    end

  end

end
