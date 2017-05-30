require_relative "../spec_helper"

def run(command)
  `ruby -Ilib ./exe/cubist --dir=#{temp_dir} #{command}`
end
