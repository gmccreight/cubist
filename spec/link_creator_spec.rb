require_relative "./spec_helper"

describe Cubist::LinkCreator do

  before :each do
    c = conf
    c.perspective = "available"
    @creator = Cubist::LinkCreator.new(conf: c)
    @finder = Cubist::SourceFilesFinder.new(conf: c)
  end

  it "should make a link the files" do
    @creator.create_link_for_relative_path("app/models/item.rb")
    expect(@finder.run.size).to eq(1)
  end

end
