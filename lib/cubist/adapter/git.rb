require 'logger'

module Cubist

  module Adapter

    class Git

      def commits_containing_files(files:)
        log_info = get_log_info(files: files)
        parse_to_commits(log_lines: log_info.lines)
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

      def get_log_info(files:)
        cmd = %Q{cd #{ENV["CUBIST_ADAPTER_GIT_DIRECTORY"]}; #{ENV["CUBIST_ADAPTER_GIT_BINARY"]} } +
        %Q{log --oneline --stat --stat-width=300 --full-diff -n 100 -- #{files.join(" ")}}
        `#{cmd}`
      end

    end

  end

end
