module Cubist

  class LinkCreator

    def initialize(conf:)
      @conf = conf
    end

    def create_link(full_file_path, link_path)
      full_link_path = @conf.cubist_folder_full_path + "/" + link_path
      FileUtils.mkdir_p(Pathname.new(full_link_path).dirname.to_s)
      File.symlink(full_file_path, full_link_path)
    end

    def create_link_for_relative_path(relative_path)
      return if ! @conf.perspective
      create_link(@conf.root + "/" + relative_path, suggested_link_path_for(relative_path))
    end

    def suggested_link_path_for(path)
      # Should handle multiple types of projects.  Starting with Rails.
      rails = LinkSuggester::Rails.new
      if rails.is_type?
        return rails.suggestion_for(path)
      end
    end

  end

end
