require_relative "./spec_helper"

describe Cubist::App do

  before :each do
    @app = Cubist::App.new
  end

  it "should be able to load a pre-existing cubist perspective" do
    dir = temp_dir
    make_perspective_file_at("alcohol")
    make_cubist_link("app/models/item.rb", "alcohol/app/models/item.rb")
    @app.set_project_root(dir)
    expect(@app.get_perspectives.size).to eq(1)
    expect(@app.get_perspectives.first).to match(/\/alcohol\//)
  end

end
