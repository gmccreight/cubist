module Cubist

  module Docs

    class LinksChecker

      def self.check_content(text:, aliases:)
        matches = text.to_enum(:scan, /\[\[(.*?)\]\]/).map { Regexp.last_match }
        result = {summary: {status: nil}, details: []}
        matches.each do |x|
          link_content = x[1]
          file, regex = LinkToFileLine.link_content_splitter(link_content)
          result_hash = LinkToFileLine.alias_for(file: file, regex: regex, aliases: aliases)
          result[:details] << result_hash
        end

        if result[:details].any?{|x| x[:status] != :success}
          result[:summary][:status] = :failure
        else
          result[:summary][:status] = :success
        end

        result
      end

    end

  end

end
