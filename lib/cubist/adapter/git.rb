module Cubist

  module Adapter

    class Git

      def commits_containing_files(files:)
        result = []
        result << Cubist::Commit.new(files: files)
        result
      end

      def parse_to_commits(log_lines:)
        result = []
        sha = nil
        files = []
        log_lines.each do |line|
          match = line.match(/^([0-9a-f]{7}) /)
          if match
            if sha != nil
              result << Cubist::Commit.new(sha: sha, files: files)
            end
            sha = match[1]
            files = []
          else
            match = line.match(/ ([^ ]+)[ ]+\|/)
            if match
              files << match[1]
            end
          end
        end
        result << Cubist::Commit.new(sha: sha, files: files)
        result
      end

      def get_git
        # return the results of something like
        # git log --oneline --stat -- path1 path2
      end

    end

  end

end
