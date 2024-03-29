module Cubist
  module Docs
    class LinkToFileLine
      def self.dest_for(doc_content:, row:, column:, aliases:)
        line = doc_content.lines[row]

        file, regex = LinkTranslator.link_regex_for(
          line: line,
          cursor_column: column
        )

        if file
          return alias_for(file: file, regex: regex, aliases: aliases)
        else
          return wrap_result(:failure, :no_link, nil, nil)
        end
      end

      def self.alias_for(file:, regex:, aliases:)
        if aliases.count { |x| x.basename == file } > 1
          return wrap_result(:failure, :more_than_one_matching, nil, nil)
        end
        aliases.each do |f|
          if f.basename == file
            matched_line = nil
            if regex
              f.content.lines.each_with_index do |inner_line, index|
                if inner_line.match(/#{regex.sub(/^[\/]/, '').sub(/[\/]$/, '')}/)
                  matched_line = index
                  break
                end
              end
            end
            return wrap_result(:success, :file_found, f.dir + '/' + f.basename, matched_line)
          end
        end
        wrap_result(:failure, :no_matching_file, nil, nil)
      end

      def self.wrap_result(status, message, file, line_num)
        { status: status, message: message, file: file, line_num: line_num }
      end
    end
  end
end
