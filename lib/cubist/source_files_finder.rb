require 'find'
require 'fileutils'

module Cubist
  class SourceFilesFinder
    def initialize(conf:)
      @conf = conf
    end

    def run(relative: false)
      files = get_files
      if relative
        files = files.map { |x| x.gsub(/^#{@conf.cubist_folder_full_path}\//, '') }
      end
      files
    end

    def get_angles
      get_files.select { |x| x =~ /\.cubist_angle$/ }.map { |x| x.gsub(/\/.cubist_angle$/, '') }
    end

    private def get_files
      dir = @conf.cubist_folder_full_path
      results = []
      Find.find(dir) do |path|
        if FileTest.directory?(path)
          if File.basename(path)[0] == '.' && File.basename(path) != '.'
            Find.prune
          else
            next
          end
        else
          results << path if File.basename(path) != '.DS_Store'
        end
      end
      results
    end
  end
end
