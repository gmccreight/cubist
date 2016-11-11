require_relative "./spec_helper"

describe Cubist::App do

  before :each do
    @app = Cubist::App.new
  end

  it "should be able to load a pre-existing cubist angle" do
    dir = temp_dir
    @app.set_project_root(dir)

    @app.make_angle("features/partner_editing_interface")
    @app.make_angle("features/availability_indicator")

    make_cubist_link("app/models/item.rb", "features/partner_editing_interface/app/models/item.rb")

    expect(@app.get_angles.size).to eq(2)
    expect(@app.get_angles.first).to eq("features/availability_indicator")
    expect(@app.get_angles.last).to eq("features/partner_editing_interface")
  end

end
