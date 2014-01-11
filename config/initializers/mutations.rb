Dir[File.join(Rails.root, 'lib', 'noted', '**', '*.rb')].each do |file|
  require file
end

Mutations.cache_constants = Rails.env.production?
