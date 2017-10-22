module Cubist

  class ReadmeLinksChecker

    def self.check_content(text:, aliases:)
      matches = text.to_enum(:scan, /\[\[(.*?)\]\]/).map { Regexp.last_match }
      result = {summary: {status: nil}, details: []}
      matches.each do |x|
        link_content = x[1]
        file, regex = ReadmeLinkToFileLine.link_content_splitter(link_content)
        status, message, file, line_num = ReadmeLinkToFileLine.alias_for(file: file, regex: regex, aliases: aliases)
        detail = {result: status, message: message, file: file, line_num: line_num}
        result[:details] << detail
      end

      if result[:details].any?{|x| x[:result] != :success}
        result[:summary][:status] = :failure
      else
        result[:summary][:status] = :success
      end

      result
    end

  end

end
