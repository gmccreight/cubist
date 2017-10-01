module Cubist

  class SmartReadmeLinkTranslator

    def smart_readme_regex_for(line:, cursor_column:)
      line.scan(/\[\[(.*?)\]\]/) do |x|
        beginning, ending = Regexp.last_match.offset(0)
        ending -= 1
        if cursor_column >= beginning and cursor_column <= ending
          file_and_maybe_regex = Regexp.last_match.captures[0]
          if file_and_maybe_regex =~ /:/
            return file_and_maybe_regex.split(/:/)
          else
            return file_and_maybe_regex, nil
          end
        end
      end

      return nil, nil
    end

  end

end
