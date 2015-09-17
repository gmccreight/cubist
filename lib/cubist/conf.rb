module Cubist

  class Conf < Struct.new(:root, :folder, :perspective)

    def cubist_folder_full_path
      root + "/" + folder
    end

  end

end
