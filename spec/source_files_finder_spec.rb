require_relative "./spec_helper"

describe Cubist::SourceFilesFinder do

  before :each do
    @finder = Cubist::SourceFilesFinder.new(conf: conf)
  end

  it "should get all the files" do
    file_and_link("app/models/item.rb", "availability/models/item.rb")
    expect(@finder.run.size).to eq(1)
    file_and_link("app/models/product.rb", "availability/models/product.rb")
    expect(@finder.run.size).to eq(2)
  end

  it "should be able to resolve the symlink" do
    file_and_link("app/models/item.rb", "availability/models/item.rb")
    expect(@finder.run.size).to eq(1)
    expect(File.readlink(@finder.run.last)).to eq(project_dir + "/app/models/item.rb")
  end

  describe "perspective files" do

    it "should find them" do
      make_perspective_file("availability/.cubist_perspective")
      file_and_link("app/models/item.rb", "availability/app/models/item.rb")

      make_perspective_file("items/.cubist_perspective")
      file_and_link("app/models/item.rb", "items/app/models/item.rb")

      make_perspective_file("features/cops_interface/.cubist_perspective")
      file_and_link("app/models/item.rb", "features/cops_interface/app/models/item.rb")

      make_perspective_file("features/messaging/.cubist_perspective")
      file_and_link("app/models/item.rb", "features/messaging/app/models/item.rb")

      expect(@finder.get_perspectives.size).to eq(4)
    end

  end

end
