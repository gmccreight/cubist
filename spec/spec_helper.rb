require "cubist"

require 'tempfile'

def conf
  return @conf if @conf
  root = Dir.mktmpdir
  Dir.mkdir(root + "/_cubist")
  @conf = Cubist::Conf.new(root, "_cubist")
end

def project_dir
  conf.root
end

def cubist_dir
  conf.root + "/" + conf.folder
end

def make_project_file(full_path, content: "")
  file_full_path = project_dir + "/" + full_path
  FileUtils.mkdir_p(Pathname.new(file_full_path).dirname.to_s)
  FileUtils.touch(file_full_path)
  file_full_path
end

def make_cubist_link(project_file_full_path, cubist_link_path)
  Cubist::LinkCreator.new(conf: conf).create_link(project_file_full_path, cubist_link_path)
end

def file_and_link(project_file_path, cubist_link_path)
  project_file_full_path = make_project_file(project_file_path)
  make_cubist_link(project_file_full_path, cubist_link_path)
end
