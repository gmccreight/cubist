module Cubist

  class LinkCreator

    def initialize(root:)
      @root = root
    end

    def create_link(full_file_path, link_path)
      full_link_path = @root + "/_cubist/" + link_path
      FileUtils.mkdir_p(Pathname.new(full_link_path).dirname.to_s)
      File.symlink(full_file_path, full_link_path)
    end

  end

end
