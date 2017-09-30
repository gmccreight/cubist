module Cubist

  class RelatedFilesFinder

    # returns
    #
    # {
    #   all: ["top_file", "next_file"],
    #   per_file: {
    #     file_1: ["top_file_for_file_1", "next_file_for_file_1"],
    #     file_2: ["top_file_for_file_2", "next_file_for_file_2"],
    #   }
    # }

    def find(files:, commits:)
      result = {all: nil, per_file: {}}
      global_score_for = {}
      global_score_for.default = 0
      files.each do |file|
        files_and_scores = _related_files(
          file: file,
          commits: commits
        )
        files_and_scores.each do |file_and_score|
          global_score_for[file_and_score[:file]] += file_and_score[:score]
        end
        result[:per_file][file] = files_and_scores
      end
      all_result = []
      global_score_for.sort_by{ |k, v| v }.reverse.each do |k, v|
        all_result << {file: k, score: v}
      end
      result[:all] = all_result
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
      result = []
      count_for.sort_by{ |k, v| v }.reverse.each do |k, v|
        result << {file: k, score: v}
      end
      result
    end

  end

end
