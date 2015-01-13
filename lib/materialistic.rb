require "materialistic/version"
require "materialistic/providers"

module Materialistic
  def self.list(query)
    providers.inject([]) do |results, provider|
      context = provider.new
      results << {
        id: underscore(context.class.to_s.gsub(/(^.+::)?/, '')),
        display_name: context.display_name,
        items: context.list(query)
      }
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

  def self.underscore(str)
    str.gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
    gsub(/([a-z\d])([A-Z])/,'\1_\2').
    tr("-", "_").
    downcase
  end

  def self.camelcase(str)
    str.to_s.split("_").map(&:capitalize).join
  end
end
