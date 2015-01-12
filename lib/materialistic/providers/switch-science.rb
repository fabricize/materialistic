# encoding: utf-8

require 'mechanize'

module Materialistic
  module Providers
    class BaseProvider
      QUANTITY_HUGE = 'qty_huge'

      def self.subclasses
        ObjectSpace.each_object(singleton_class).select{ |klass| klass.superclass == self }
      end
    end

    class SwitchScience < BaseProvider
      def initialize
        @agent = Mechanize.new
      end

      def display_name
        'Switch Science'
      end

      def find(query)
        page = @agent.get "https://www.switch-science.com/catalog/list?keyword=#{query}"

        products = page/'.products_thumb/li'
        products.inject([]) do |result, product|
          quantity = (product/'.detail/#quantity-message').text.strip.gsub(/^在庫：/, '')

          result << {
            name: (product/'.detail/p').text.strip,
            description: (product/'img').attr('title').text.strip,
            sku: (product/'img').attr('alt').text.strip,
            price: (product/'.detail/.price').text.strip.gsub(/\D/, '').to_i,
            currency: 'JPY',
            quantity: quantity == '多数' ? QUANTITY_HUGE : quantity,
            image: "https:" + (product/'img').attr('src').text.strip
          }
        end
      end
    end
  end
end
