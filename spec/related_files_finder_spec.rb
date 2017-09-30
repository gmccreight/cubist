require_relative "./spec_helper"

describe Cubist::RelatedFilesFinder do

  before :each do
    @finder = Cubist::RelatedFilesFinder.new()
    @commits = [
      commit([
        "app/models/item.rb",
        "spec/models/item_spec.rb"
      ]),
      commit([
        "app/models/item.rb",
        "app/models/product.rb",
        "spec/models/item_spec.rb"
      ]),
      commit([
        "app/models/store.rb",
        "spec/models/store_spec.rb"
      ]),
      commit([
        "app/models/item.rb",
        "app/models/item_image.rb",
        "spec/models/item_spec.rb"
      ]),
      commit([
        "app/models/item.rb",
        "app/models/item_image.rb"
      ])
    ]
  end

  def commit(files)
    Cubist::Commit.new(sha: nil, files: files)
  end

  it "should get all related files ranked by the number of times they have been committed together" do
    files = @finder.find(files: ["app/models/item.rb"], commits: @commits)
    expect(files).to eq(
      {"app/models/item.rb" =>
        [
        "spec/models/item_spec.rb",
        "app/models/item_image.rb",
        "app/models/product.rb"
        ]
      }
    )

    10.times {
      @commits << commit([
        "app/models/item.rb",
        "app/models/product.rb",
      ])
    }

    files = @finder.find(files: ["app/models/item.rb"], commits: @commits)
    expect(files).to eq(
      {"app/models/item.rb" =>
        [
        "app/models/product.rb",
        "spec/models/item_spec.rb",
        "app/models/item_image.rb"
        ]
      }
    )
  end
  it "should work with an alternative set of data" do
    files = @finder.find(files: ["spec/models/store_spec.rb"], commits: @commits)
    expect(files).to eq(
      {"spec/models/store_spec.rb" => ["app/models/store.rb"]}
    )
  end
  it "should return the scores if you ask for them" do
    files = @finder.find(files: ["spec/models/store_spec.rb"], commits: @commits, keep_scores: true)
    expect(files).to eq(
      {"spec/models/store_spec.rb" => [["app/models/store.rb", 1]]}
    )
  end

end
