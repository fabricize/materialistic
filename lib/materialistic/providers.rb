module Materialistic
  module Providers
    class Base
      QUANTITY_UNKNOWN = 'QTY_UNKNOWN'
      QUANTITY_HUGE = 'QTY_HUGE'

      def id
        underscore(self.class.to_s.gsub(/(^.+::)?/, ''))
      end

      private

      def underscore(str)
        str.gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
        gsub(/([a-z\d])([A-Z])/,'\1_\2').
        tr("-", "_").
        downcase
      end
    end
  end
end

Dir[File.expand_path('../providers', __FILE__) << '/*.rb'].each do |file|
  require file
end
