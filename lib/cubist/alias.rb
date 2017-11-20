module Cubist
  class Alias < Struct.new(
    :dir, :basename, :target_dir, :target_basename, :content
  )
  end
end
