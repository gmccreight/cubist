module Cubist

  class Perspective

    def initialize(conf:)
      @conf = conf
    end

    def all
      files = SourceFilesFinder.new(conf: @conf).get_perspectives
      files.map{|x| x.sub(/^#{@conf.cubist_folder_full_path}\//, '')}
    end

  end

end
