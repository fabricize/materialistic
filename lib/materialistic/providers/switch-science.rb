# encoding: utf-8

require 'mechanize'

module Materialistic
  module Providers
    class SwitchScience < Base
      def initialize
        @agent = Mechanize.new
      end

      def display_name
        'Switch Science'
      end

      def list(query)
        page = @agent.get "https://www.switch-science.com/catalog/list?keyword=#{query}"

        products = page/'.products_thumb/li'
        products.inject([]) do |result, product|
          quantity = (product/'.detail/#quantity-message').text.strip.gsub(/^在庫：/, '')

          result << {
            name: (product/'.detail/p').text.strip,
            description: (product/'img').attr('title').text.strip,
            mpn: (product/'img').attr('alt').text.strip,
            sku: (product/'.addcart/input[name=plu]').attr('value').text,
            price: (product/'.detail/.price').text.strip.gsub(/\D/, '').to_i,
            currency: 'JPY',
            quantity: quantity == '多数' ? QUANTITY_HUGE : quantity,
            url: page.uri.merge((product/'a').attr('href').text).to_s,
            image: "https:" + (product/'img').attr('src').text
          }
        end

        def item(sku)
          page = @agent.get "https://www.switch-science.com/catalog/#{sku}/"

          table = (page/'.table-bordered-rect/tr')
          quantity = (table[7]/'td').text.strip

          {
            name: (table[1]/'td').text.strip,
            description: (page/'#description').text.strip,
            mpn: (table[2]/'td').text,
            sku: (table[3]/'td').text,
            postage_class: (table[4]/'td/span').text.to_i,
            price: (table[5]/'td/.price').text.strip.gsub(/\D/, '').to_i,
            currency: 'JPY',
            quantity: quantity == '多数' ? QUANTITY_HUGE : quantity,
            url: page.uri.to_s,
            image: (table[0]/'a').attr('href').text
          }
        end
      end
    end
  end
end
