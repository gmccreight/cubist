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
        content: "line0\nline1\nline2\n"
      },
      {
        link_directory: "folder2",
        link_basename: "file2",
        target_directory: "folder2",
        target_basename: "file2",
        content: "line0\nline1\nline2\n"
      }
    ]
  end

  context "cursor on the link" do

    def link_for_readme(readme)
      result, filename, line_num = @klass.dest_for(
        readme: readme,
        row: 0,
        column:9,
        files: @files
      )
      return result, filename, line_num
    end

    it "should be able to identify the whole file you should go to if no regex" do
      readme = "Before [[file1]] after"
      result, filename, line_num = link_for_readme(readme)
      expect(result).to eq(:success)
      expect(filename).to eq("folder1/file1")
    end

    context "where link has regex" do

      it "should be able to identify the file and line if regex" do
        readme = "Before [[file1:/line2/]] after"
        result, filename, line_num = link_for_readme(readme)
        expect(result).to eq(:success)
        expect(filename).to eq("folder1/file1")
        expect(line_num).to eq(2)
      end

      it "should return the first line matching regex" do
        readme = "Before [[file1:/line/]] after"
        result, filename, line_num = link_for_readme(readme)
        expect(result).to eq(:success)
        expect(filename).to eq("folder1/file1")
        expect(line_num).to eq(0)
      end

    end

    it "should fail if multiple files match" do
      @files << 
        {
          link_directory: "folder3",
          link_basename: "file1",
          target_directory: "folder3",
          target_basename: "file1",
          content: "line0\nline1\nline2\n"
        }
      readme = "Before [[file1]] after"
      result, filename, line_num = link_for_readme(readme)
      expect(result).to eq(:fail)
      expect(filename).to eq(:more_than_one_matching)
    end

    it "should not me able to find a file that does not exist" do
      readme = "Before [[file8]] after"
      result, filename, line_num = link_for_readme(readme)
      expect(result).to eq(:fail)
      expect(filename).to eq(:no_matching_file)
    end

    it "should work in a multi-line readme" do
      readme = "Line before\n[[file1]] after"
      result, filename, line_num = @klass.dest_for(
        readme: readme,
        row: 1,
        column:2,
        files: @files
      )
      expect(result).to eq(:success)
      expect(filename).to eq("folder1/file1")
    end

  end

  context "cursor not on the link" do

    it "should not return a file" do
      readme = "Before [[file1]] after"
      result, filename, line_num = @klass.dest_for(readme: readme, row: 0, column:0, files: @files)
      expect(result).to eq(:fail)
      expect(filename).to eq(:no_link)
    end

  end

end
