module Cubist

  class ReadmeLinkToFileLine

    def self.dest_for(readme:, row:, column:, files:)

      line = readme.lines[row]

      file, regex = SmartReadmeLinkTranslator.new.smart_readme_regex_for(
        line: line,
        cursor_column: column
      )

      if file
        files.each do |f|
          if f[:basename] == file
            return :success, f[:folder] + "/" + f[:basename]
          end
        end
      else
        return :fail, :no_link
      end
    end

  end

end
