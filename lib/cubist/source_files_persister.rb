module Cubist
  class SourceFilesPersister
    def initialize(app:)
      @app = app
    end

    def persist_paths(paths)
      data_structure = create_data_structure(paths)
      @app.write_conf_file(data_structure)
      true
    end

    def create_data_structure(paths)
      paths.join("\n")
    end
  end
end
