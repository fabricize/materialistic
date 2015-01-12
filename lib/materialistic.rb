require "materialistic/version"
Dir[File.expand_path('../materialistic/providers', __FILE__) << '/*.rb'].each do |file|
  require file
end

module Materialistic
  def self.find(query)
    providers = Materialistic::Providers::BaseProvider.subclasses
    providers.inject([]) do |results, provider|
      context = provider.new
      results << {
        id: underscore(context.class.to_s.gsub(/(^.+::)?/, '')),
        display_name: context.display_name,
        items: context.find(query)
      }
    end
  end

  private

  def self.underscore(str)
    str.gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
    gsub(/([a-z\d])([A-Z])/,'\1_\2').
    tr("-", "_").
    downcase
  end
end
