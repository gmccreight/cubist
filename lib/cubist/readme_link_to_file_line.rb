module Cubist

  class ReadmeLinkToFileLine

    def self.dest_for(readme:, row:, column:, files:)

      line = readme.lines[row]

      file, regex = SmartReadmeLinkTranslator.new.smart_readme_regex_for(
        line: line,
        cursor_column: column
      )

      if file
        if files.select{|x| x[:link_basename] == file}.size > 1
          return :fail, :more_than_one_matching, nil
        end
        files.each do |f|
          if f[:link_basename] == file
            matched_line = nil
            if regex
              f[:content].lines.each_with_index do |line, index|
                if line.match(/#{regex.sub(/^[\/]/, '').sub(/[\/]$/, '')}/)
                  matched_line = index
                  break
                end
              end
            end
            return :success, f[:link_directory] + "/" + f[:link_basename], matched_line
          end
        end
        return :fail, :no_matching_file, nil
      else
        return :fail, :no_link, nil
      end
    end

  end

end
