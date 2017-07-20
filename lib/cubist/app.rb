module Cubist

  class App

    def initialize
      @conf = nil
    end

    def set_project_root(root)
      if @conf
        @conf.root = root
      else
        @conf = Cubist::Conf.new(root, "_cubist")
      end
    end

    def set_cubist_folder(cubist_folder)
      if @conf
        @conf.folder = cubist_folder
      else
        @conf = Cubist::Conf.new(nil, cubist_folder)
      end
    end

    def get_angles
      ::Cubist::Angle.new(conf: @conf).all
    end

    def make_angle(relative_path)
      file_full_path = @conf.cubist_folder_full_path + "/" + relative_path + "/.cubist_angle"
      FileUtils.mkdir_p(Pathname.new(file_full_path).dirname.to_s)
      FileUtils.touch(file_full_path)
    end

    def get_related_files(relative_path)
      finder = Cubist::RelatedFilesFinder.new()
      commits = Cubist::Adapter::Git.new.commits_containing_files(files: [relative_path])
      files = finder.find(files: [relative_path], commits: commits)
      alive = []
      unlinked = []
      files[relative_path].each do |file|
        if File.exists?(ENV["CUBIST_ADAPTER_GIT_DIRECTORY"] + "/" + file)
          alive << file
        else
          unlinked << file
        end
      end
      if unlinked.size > 0
        puts alive.map{|x| "alive #{x}"} + unlinked.map{|x| "unlinked #{x}"}
      else
        puts alive.map{|x| x}
      end
    end

    def write_conf_file(data)
      File.write(conf_file_path, data)
    end

    def read_conf_file
      File.read(conf_file_path)
    end

    def conf_file_path
      @conf.root_full_path + "/.cubist_data"
    end

  end

end
