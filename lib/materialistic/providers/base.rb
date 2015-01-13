module Materialistic
  module Providers
    class Base
      QUANTITY_HUGE = 'QTY_HUGE'

      def id
        self.class.to_s.gsub(/(^.+::)?/, '')
      end
    end
  end
end
