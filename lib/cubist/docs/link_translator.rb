module Cubist
  module Docs
    class LinkTranslator
      def self.link_regex_for(line:, cursor_column:)
        line.scan(/\[\[(.*?)\]\]/) do |_x|
          beginning, ending = Regexp.last_match.offset(0)
          ending -= 1
          if cursor_column >= beginning && cursor_column <= ending
            link_content = Regexp.last_match.captures[0]
            return Link.content_splitter(link_content)
          end
        end

        [nil, nil]
      end
    end
  end
end
