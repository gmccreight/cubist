module Cubist

  class ReadmeLinkToFileLine

    def self.dest_for(readme:, row:, column:, aliases:)

      line = readme.lines[row]

      file, regex = SmartReadmeLinkTranslator.new.smart_readme_regex_for(
        line: line,
        cursor_column: column
      )

      if file
        if aliases.select{|x| x.basename == file}.size > 1
          return :fail, :more_than_one_matching, nil, nil
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
            return :success, :file_found, f.dir + "/" + f.basename, matched_line
          end
        end
        return :fail, :no_matching_file, nil, nil
      else
        return :fail, :no_link, nil, nil
      end
    end

  end

end
