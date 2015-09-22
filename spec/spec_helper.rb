require "cubist"

require 'tempfile'

def conf
  return @conf if @conf
  root = temp_dir
  if !File.exists?(root + "/_cubist")
    Dir.mkdir(root + "/_cubist")
  end
  @conf = Cubist::Conf.new(root, "_cubist")
end

def temp_dir
  @temp_dir ||= Dir.mktmpdir
end

def project_dir
  temp_dir
end

def make_project_file(full_path, content: "")
  file_full_path = project_dir + "/" + full_path
  FileUtils.mkdir_p(Pathname.new(file_full_path).dirname.to_s)
  FileUtils.touch(file_full_path)
  file_full_path
end

def make_perspective_file_at(relative_path)
  file_full_path = conf.cubist_folder_full_path + "/" + relative_path + "/.cubist_perspective"
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
