module Cubist

  class RelatedFilesFinder

    def find(files:, commits:)
      result = {}
      files.each do |file|
        result[file] = _related_files(file: file, commits: commits)
      end
      result
    end

    def _related_files(file:, commits:)
      count_for = {}
      count_for.default = 0
      commits.each do |commit|
        if ! commit.contains_file?(file)
          next
        end
        commit.files.reject{|x| x == file}.each do |f|
          count_for[f] += 1
        end
      end
      count_for.sort_by{ |k, v| v }.reverse.map{|x| x[0]}
    end

  end

end
