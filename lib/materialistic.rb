require "materialistic/version"
require "materialistic/providers"

module Materialistic
  def self.list(query)
    providers.inject([]) do |results, provider|
      context = provider.new
      id = context.id
      items = context.list(query)
      items.each do |item|
        results << item[:provider] = id
      end
    end
  end

  def self.item(args)
    provider_id, sku = args.to_a.first

    provider = Object.const_get("Materialistic::Providers::#{camelcase(provider_id)}").new
    provider.item(sku)
  end

  private

  def self.providers
    ObjectSpace.each_object(Providers::Base.singleton_class).select{ |klass| klass.superclass == Providers::Base }
  end

  def self.camelcase(str)
    str.to_s.split("_").map(&:capitalize).join
  end
end
