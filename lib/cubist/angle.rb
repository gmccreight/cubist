module Cubist

  class Angle

    def initialize(conf:)
      @conf = conf
    end

    def all
      files = SourceFilesFinder.new(conf: @conf).get_angles
      files.map{|x| x.sub(/^#{@conf.cubist_folder_full_path}\//, '')}
    end

  end

end
