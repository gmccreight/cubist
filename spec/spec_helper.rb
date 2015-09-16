require "cubist"

def project_dir
  return @project_dir if @project_dir
  @project_dir = Dir.mktmpdir
end

def cubist_dir
  return @cubist_dir if @cubist_dir
  @cubist_dir = project_dir + "/_cubist"
  Dir.mkdir(@cubist_dir)
  @cubist_dir
end

def make_project_file(full_path, content: "")
  file_full_path = project_dir + "/" + full_path
  FileUtils.mkdir_p(Pathname.new(file_full_path).dirname.to_s)
  FileUtils.touch(file_full_path)
  file_full_path
end

def make_cubist_link(project_file_full_path, cubist_link_path)
  cubist_link_full_path = cubist_dir + "/" + cubist_link_path
  FileUtils.mkdir_p(Pathname.new(cubist_link_full_path).dirname.to_s)
  File.symlink(project_file_full_path, cubist_link_full_path)
end

def file_and_link(project_file_path, cubist_link_path)
  project_file_full_path = make_project_file(project_file_path)
  make_cubist_link(project_file_full_path, cubist_link_path)
end

