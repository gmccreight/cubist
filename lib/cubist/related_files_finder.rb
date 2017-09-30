module Cubist

  class RelatedFilesFinder

    def find(files:, commits:, keep_scores: false)
      result = {}
      files.each do |file|
        result[file] = _related_files(
          file: file,
          commits: commits,
          keep_scores: keep_scores
        )
      end
      result
    end

    def _related_files(file:, commits:, keep_scores:)
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
      sorted = count_for.sort_by{ |k, v| v }.reverse
      if keep_scores
        sorted
      else
        sorted.map{|x| x[0]}
      end
    end

  end

end
