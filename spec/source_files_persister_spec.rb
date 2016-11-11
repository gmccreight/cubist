require_relative "./spec_helper"

describe Cubist::SourceFilesPersister do

  before :each do
    @app = Cubist::App.new
    @dir = temp_dir
    @app.set_project_root(@dir)
    @persister = Cubist::SourceFilesPersister.new(app: @app)
  end

  it "should persist the files into a hand-readable and editable data structure" do
    make_angle_file_at("features/availability")
    file_and_link("app/models/item.rb", "features/availability/models/item.rb")
    file_and_link("app/models/product.rb", "features/availability/models/product.rb")
    file_and_link("app/services/product_finder_service.rb", "features/availability/services/product_finder_service.rb")
    link_file_paths = Cubist::SourceFilesFinder.new(conf: conf).run(relative: true)
    expect(@persister.persist_paths(link_file_paths)).to eq(true)
    expect(@app.read_conf_file()).to match(/availability/)
  end

end
