Dir[File.join(Rails.root, 'lib', 'noted', '**', '*.rb')].each do |file|
  require file
end
