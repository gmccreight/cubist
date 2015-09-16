require_relative "./spec_helper"

require 'tempfile'
require 'fileutils'

describe Cubist::SourceFilesFinder do

  before :each do
    @dest_dir = Dir.mktmpdir
    @finder = Cubist::SourceFilesFinder.new(root: @dest_dir)
  end

  def make_file(fullpath)
    FileUtils.touch(@dest_dir + "/" + fullpath)
  end

  it "should get all the files" do
    make_file("foo1.txt")
    expect(@finder.run.size).to eq(1)
    make_file("foo2.txt")
    expect(@finder.run.size).to eq(2)
  end

end
