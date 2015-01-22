# encoding: utf-8

require 'mechanize'

module Materialistic
  module Providers
    class Akizuki < Base
      def initialize
        @agent = Mechanize.new
      end

      def display_name
        'Akizuki Denshi'
      end

      def list(query)
        page = @agent.get "http://akizukidenshi.com/catalog/goods/search.aspx?search=x&keyword=#{query}"

        products = page/'.thumbox'
        products.inject([]) do |result, product|
          table = product/'table td'
          if table[1].children.size > 1
            mpn = table[1].children[0].text.gsub(/\[|\]|\s/, '')
            sku = table[1].children[2].text.gsub(/\[|\]|\s/, '')
          else
            sku = table[1].text.gsub(/\[|\]|\s/, '')
            mpn = sku
          end

          result << {
            name: (product/'.goods_name_').attr('title').text,
            description: nil,
            mpn: mpn,
            sku: sku,
            price: (product/'table td')[2].children[1].text.gsub(/\D/, '').to_i,
            currency: 'JPY',
            quantity: QUANTITY_UNKNOWN,
            url: page.uri.merge((product/'.goods_name_').attr('href')).to_s,
            image: page.uri.merge((product/'.goods_name_/img').attr('src')).to_s
          }
        end
      end

      def item(sku)
        page = @agent.get "http://akizukidenshi.com/catalog/g/g#{sku}/"

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
