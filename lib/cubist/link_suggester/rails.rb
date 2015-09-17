module Cubist
  module LinkSuggester
    class Rails
      def is_type?
        true
      end
      def suggestion_for(path)
        path
      end
    end
  end
end
