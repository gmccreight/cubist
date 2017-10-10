require_relative "./spec_helper"

describe Cubist::ReadmeLinkToFileLine do

  before :each do
    @klass = Cubist::ReadmeLinkToFileLine
    @files = [
      {
        link_directory: "folder1",
        link_basename: "file1",
        target_directory: "folder1",
        target_basename: "file1",
        content: "line1\nline2\nline3\n"
      },
      {
        link_directory: "folder2",
        link_basename: "file2",
        target_directory: "folder2",
        target_basename: "file2",
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

  it "should be able to identify the whole file you should go to if no regex" do
    @files << 
      {
        link_directory: "folder3",
        link_basename: "file1",
        target_directory: "folder3",
        target_basename: "file1",
        content: "line1\nline2\nline3\n"
      }
    readme = "Before [[file1]] after"
    result, filename = @klass.dest_for(readme: readme, row: 0, column:9, files: @files)
    expect(result).to eq(:fail)
    expect(filename).to eq(:more_than_one_matching)
  end

  it "should not me able to find a file that does not exist" do
    readme = "Before [[file8]] after"
    result, filename = @klass.dest_for(readme: readme, row: 0, column:9, files: @files)
    expect(result).to eq(:fail)
    expect(filename).to eq(:no_matching_file)
  end

end
