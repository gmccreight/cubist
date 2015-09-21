module Cubist

  class App

    def initialize
      @conf = nil
    end

    def set_project_root(root)
      if @conf
        conf.root = root
      else
        @conf = Cubist::Conf.new(root, "_cubist")
      end
    end

    def set_cubist_folder(cubist_folder)
      if @conf
        conf.folder = cubist_folder
      else
        @conf = Cubist::Conf.new(nil, cubist_folder)
      end
    end

    def get_perspectives
      SourceFilesFinder.new(conf: @conf).get_perspectives
    end

  end

end
