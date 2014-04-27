ELASTICSEARCH_URL = ENV['ELASTICSEARCH_URL'] || "http://localhost:9200"

Noted::Application.configure do
  config.elasticsearch_url = ELASTICSEARCH_URL
  config.elasticsearch = Elasticsearch::Client.new(url: ELASTICSEARCH_URL,
       logger: Rails.env.production?() ? nil : Rails.logger ,
       tracer: Rails.env.production?() ? nil : Rails.logger )
end
