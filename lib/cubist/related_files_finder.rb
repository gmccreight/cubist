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
          global_score_for[file_and_score[0]] += file_and_score[1]
        end
        result[:per_file][file] = files_and_scores.map{|x| x[0]}
      end
      result[:all] = global_score_for.sort_by{ |k, v| v }.reverse.map{|x| x[0]}
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
      count_for.sort_by{ |k, v| v }.reverse
    end

  end

end
