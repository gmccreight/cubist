module Cubist
  class Conf < Struct.new(:root, :folder, :angle)
    def cubist_folder_full_path
      root + '/' + folder
    end

    def root_full_path
      root
    end
  end
end
