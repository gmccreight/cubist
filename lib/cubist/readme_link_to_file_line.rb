module Cubist

  class ReadmeLinkToFileLine

    def self.dest_for(readme:, row:, column:, files:)

      line = readme.lines[row]

      file, regex = SmartReadmeLinkTranslator.new.smart_readme_regex_for(
        line: line,
        cursor_column: column
      )

      files.each do |f|
        if f[:path].match(/(^|\/)#{file}$/)
          return f[:path]
        end
      end

      return nil
    end

  end

end
