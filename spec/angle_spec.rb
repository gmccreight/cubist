require_relative "./spec_helper"

describe Cubist::Angle do

  it "should return the angle for a nested file" do
    make_angle_file_at("availability")
    file_and_link("app/models/item.rb", "availability/models/item.rb")
    make_angle_file_at("prods")
    file_and_link("app/models/product.rb", "prods/models/product.rb")
    angle = Cubist::Angle.angle_for_nested_file(conf: nil, filename: project_dir + "/_cubist/prods/models/product.rb")
    expect(angle.name).to eq("prods")
  end

  it "should return all the aliases associated with the angle associated with the nested file" do
    make_angle_file_at("availability")
    file_and_link("app/models/item.rb", "availability/models/item.rb")
    make_angle_file_at("prods")
    file_and_link("yepyep/models/product.rb", "prods/models/product.rb")
    angle = Cubist::Angle.angle_for_nested_file(conf: nil, filename: project_dir + "/_cubist/prods/models/product.rb")
    expect(angle.aliases[0].target_dir).to match(/yepyep/)
  end

end
