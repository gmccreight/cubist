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

  describe "all" do
    it "should get the top ranked files by all connections between all files" do
      commits = []
      commits << commit([
        "app/models/item.rb",
        "spec/models/item_spec.rb"
      ])
      commits << commit([
        "app/models/item.rb",
        "app/models/product.rb",
        "spec/models/item_spec.rb"
      ])
      commits << commit([
        "app/models/product.rb",
        "spec/models/product_spec.rb"
      ])
      commits << commit([
        "app/models/product.rb",
        "spec/models/product_spec.rb"
      ])

      files = @finder.find(
        files: ["spec/models/item_spec.rb", "spec/models/product_spec.rb"],
        commits: commits
      )
      expect(files[:all].first(2)).to eq(["app/models/product.rb", "app/models/item.rb"])

      2.times do
        commits << commit([
          "app/models/item.rb",
          "spec/models/item_spec.rb"
        ])
      end

      files = @finder.find(
        files: ["spec/models/item_spec.rb", "spec/models/product_spec.rb"],
        commits: commits
      )
      expect(files[:all].first(2)).to eq(["app/models/item.rb", "app/models/product.rb"])

    end
  end

  describe "per_file" do
    def expect_per_file_for(filename, expected_files)
      files = @finder.find(files: [filename], commits: @commits)
      per_file = files[:per_file][filename]
      expect(per_file).to eq(expected_files)
    end
    it "should get all related files ranked by the number of times they have been committed together" do
      expect_per_file_for(
        "app/models/item.rb", 
        [
          "spec/models/item_spec.rb",
          "app/models/item_image.rb",
          "app/models/product.rb"
        ]
      )

      10.times {
        @commits << commit([
          "app/models/item.rb",
          "app/models/product.rb",
        ])
      }

      expect_per_file_for(
        "app/models/item.rb", 
        [
          "app/models/product.rb",
          "spec/models/item_spec.rb",
          "app/models/item_image.rb"
        ]
      )
    end
    it "should work with an alternative set of data" do
      expect_per_file_for( "spec/models/store_spec.rb", ["app/models/store.rb"])
    end
  end
end
