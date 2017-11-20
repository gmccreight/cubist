module Cubist

  module Docs

    class Link

      def self.content_splitter(link_content)
        link_content.split(/:/)
      end

    end

  end

end
