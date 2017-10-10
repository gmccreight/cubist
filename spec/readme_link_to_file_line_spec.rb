require_relative "./spec_helper"

describe Cubist::ReadmeLinkToFileLine do

  before :each do
    @klass = Cubist::ReadmeLinkToFileLine
    @files = [
      {
        folder: "folder1",
        basename: "file1",
        content: "line1\nline2\nline3\n"
      },
      {
        folder: "folder2",
        basename: "file2",
        content: "line1\nline2\nline3\n"
      }
    ]
  end

  it "should not go to a file if the cursor is not there" do
    readme = "Before [[file1]] after"
    result, filename = @klass.dest_for(readme: readme, row: 0, column:0, files: @files)
    expect(result).to eq(:fail)
    expect(filename).to eq(:no_link)
  end

  it "should be able to identify the whole file you should go to if no regex" do
    readme = "Before [[file1]] after"
    result, filename = @klass.dest_for(readme: readme, row: 0, column:9, files: @files)
    expect(result).to eq(:success)
    expect(filename).to eq("folder1/file1")
  end

end
