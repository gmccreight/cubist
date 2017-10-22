module Cubist

  class SmartReadmeLinkTranslator

    def smart_readme_regex_for(line:, cursor_column:)
      line.scan(/\[\[(.*?)\]\]/) do |x|
        beginning, ending = Regexp.last_match.offset(0)
        ending -= 1
        if cursor_column >= beginning and cursor_column <= ending
          link_content = Regexp.last_match.captures[0]
          return ReadmeLinkToFileLine.link_content_splitter(link_content)
        end
      end

      return nil, nil
    end

  end

end
