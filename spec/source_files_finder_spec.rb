require_relative "./spec_helper"

require 'tempfile'
require 'fileutils'
require 'pathname'

describe Cubist::SourceFilesFinder do

  before :each do
    @dest_dir = Dir.mktmpdir
    cubist_dir = @dest_dir + "/_cubist"
    Dir.mkdir(cubist_dir)
    @finder = Cubist::SourceFilesFinder.new(root: cubist_dir)
  end

  def file_and_link(fullpath, linkpath)
    file_full_path = @dest_dir + "/" + fullpath
    link_full_path = @dest_dir + "/_cubist/" + linkpath

    FileUtils.mkdir_p(Pathname.new(file_full_path).dirname.to_s)
    FileUtils.mkdir_p(Pathname.new(link_full_path).dirname.to_s)

    FileUtils.touch(file_full_path)
    File.symlink(file_full_path, link_full_path)
  end

  it "should get all the files" do
    file_and_link("app/models/item.rb", "availability/models/item.rb")
    expect(@finder.run.size).to eq(1)
    file_and_link("app/models/product.rb", "availability/models/product.rb")
    expect(@finder.run.size).to eq(2)
  end

  it "should be able to resolve the symlink" do
    file_and_link("app/models/item.rb", "availability/models/item.rb")
    expect(File.readlink(@finder.run.last)).to eq(@dest_dir + "/app/models/item.rb")
  end

end
