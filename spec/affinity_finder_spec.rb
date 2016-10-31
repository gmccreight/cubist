require_relative "./spec_helper"

describe Cubist::AffinityFinder do

  before :each do
    @finder = Cubist::AffinityFinder.new()
  end

  it "should get all the files" do
    commits = [
      Cubist::Commit.new(files: [
        "app/models/item.rb",
        "spec/models/item_spec.rb"
      ]),
      Cubist::Commit.new(files: [
        "app/models/item.rb",
        "app/models/product.rb",
        "spec/models/item_spec.rb"
      ]),
      Cubist::Commit.new(files: [
        "app/models/store.rb",
        "spec/models/store_spec.rb"
      ]),
      Cubist::Commit.new(files: [
        "app/models/item.rb",
        "app/models/item_image.rb",
        "spec/models/item_spec.rb"
      ]),
      Cubist::Commit.new(files: [
        "app/models/item.rb",
        "app/models/item_image.rb"
      ])
    ]
    files = @finder.find(files: ["app/models/item.rb"], commits: commits)
    expect(files).to eq(
      {"app/models/item.rb" =>
        [
        "spec/models/item_spec.rb",
        "app/models/item_image.rb",
        "app/models/product.rb"
        ]
      }
    )
    files = @finder.find(files: ["spec/models/store_spec.rb"], commits: commits)
    expect(files).to eq(
      {"spec/models/store_spec.rb" => ["app/models/store.rb"]}
    )
  end

end
