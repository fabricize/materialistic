Dir[File.expand_path('../providers', __FILE__) << '/*.rb'].each do |file|
  require file
end

module Providers

end
