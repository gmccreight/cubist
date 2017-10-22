module Cubist

  class ReadmeLinkToFileLine

    # TODO - extract this to separate place
    def self.dest_for(readme:, row:, column:, aliases:)

      line = readme.lines[row]

      file, regex = SmartReadmeLinkTranslator.new.smart_readme_regex_for(
        line: line,
        cursor_column: column
      )

      if file
        return alias_for(file: file, regex: regex, aliases: aliases)
      else
        return :fail, :no_link, nil, nil
      end
    end

    def self.alias_for(file:, regex:, aliases:)
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
    end

    def self.link_content_splitter(link_content)
      if link_content =~ /:/
        return link_content.split(/:/)
      else
        return link_content, nil
      end
    end

  end

end
