module Cubist

  # Given a set of links 

  class SourceFilesPersister

    def initialize(conf:)
      @conf = conf
    end

    def persist_paths(paths)
      data_structure = create_data_structure(paths)
      data_structure
    end

    def create_data_structure(paths)

    end

  end

end
