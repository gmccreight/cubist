module Cubist
  class Angle
    def self.angle_for_nested_file(conf:, filename:)
      directory = File.dirname(filename)
      while directory != '/'
        if File.exist?(File.join(directory, '.cubist_angle'))
          return new(conf: conf, name: File.basename(directory), directory: directory)
        else
          directory = File.expand_path('..', directory)
        end
      end
      nil
    end

    def self.all(conf:)
      files = SourceFilesFinder.new(conf: conf).get_angles
      files.map { |x| x.sub(/^#{conf.cubist_folder_full_path}\//, '') }
    end

    def initialize(conf:, name:, directory:)
      @conf = conf
      @name = name
      @directory = directory
    end

    attr_reader :name

    def aliases
      results = []
      Find.find(@directory) do |path|
        if FileTest.directory?(path)
          if File.basename(path)[0] == '.' && File.basename(path) != '.'
            Find.prune
          else
            next
          end
        else
          if File.symlink?(path)
            results << Alias.new(
              File.dirname(path),
              File.basename(path),
              File.dirname(File.realpath(path)),
              File.basename(File.realpath(path)),
              File.read(path)
            )
          end
        end
      end
      results
    end
  end
end
