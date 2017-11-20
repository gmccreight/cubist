require_relative '../spec_helper'

def run(command, env = '')
  `#{env} ruby -Ilib ./exe/cubist --dir=#{temp_dir} #{command}`
end
