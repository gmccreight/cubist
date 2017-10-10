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
          return :fail, :more_than_one_matching
        end
        files.each do |f|
          if f[:link_basename] == file
            return :success, f[:link_directory] + "/" + f[:link_basename]
          end
        end
        return :fail, :no_matching_file
      else
        return :fail, :no_link
      end
    end

  end

end
