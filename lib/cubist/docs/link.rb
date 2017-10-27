module Cubist

  module Docs

    class Link

      def self.content_splitter(link_content)
        if link_content =~ /:/
          return link_content.split(/:/)
        else
          return link_content, nil
        end
      end

    end

  end

end
