require_relative "./spec_helper"

module Cubist

  describe ReadmeLinksChecker do

    before :each do
      @aliases = [
        Alias.new(
          "folder1",
          "file1",
          "folder1",
          "file1",
          "line0\nline1\nline2\n"
        ),
        Alias.new(
          "folder2",
          "file2",
          "folder2",
          "file2",
          "line0\nline1\nline2\n"
        )
      ]
    end

    it "validates when all links valid" do
      text = "This is a test of [[file1]] and\ntest [[file2]]"
      result = described_class.check_content(text: text, aliases: @aliases)
      expect(result[:summary][:status]).to eq(:success)
    end

    it "does not validates when one link is invalid" do
      text = "This is a test of [[file1]] and\ntest [[not-a-link]]"
      result = described_class.check_content(text: text, aliases: @aliases)
      expect(result[:summary][:status]).to eq(:failure)
    end

  end

end
