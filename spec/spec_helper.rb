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
