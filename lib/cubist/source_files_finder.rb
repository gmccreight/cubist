require 'find'
require 'fileutils'

module Cubist

  class SourceFilesFinder

    def initialize(conf:)
      @conf = conf
    end

    def run
      get_files
    end

    private def get_files
      dir = @conf.cubist_folder_full_path
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
