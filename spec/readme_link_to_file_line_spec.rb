require_relative "./spec_helper"

describe Cubist::ReadmeLinkToFileLine do

  before :each do
    @klass = Cubist::ReadmeLinkToFileLine
    @files = [
      {
        path: "folder1/file1",
        content: "line1\nline2\nline3\n"
      },
      {
        path: "folder2/file2",
        content: "line1\nline2\nline3\n"
      }
    ]
  end

  it "should be able to identify that you are within the special link" do
    readme = "Before [[file1]] after"
    result = @klass.dest_for(readme: readme, row: 0, column:9, files: @files)
    expect(result).to eq("folder1/file1")
  end

end
