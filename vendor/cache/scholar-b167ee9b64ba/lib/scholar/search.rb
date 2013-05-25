module Scholar

  # A Search object containing search results
  # for a query (currently only searches the
  # Google Books API).
  class Search

    # The query performed.
    attr_reader :query

    # The results of the query.
    attr_reader :results

    # Searches for sources in Google Books.
    #
    # ==== Attributes
    #
    # * +query+ - The search term.
    def initialize(query)
      @@connection = Faraday.new(:url => "https://www.googleapis.com") do |f|
        f.request  :json
        f.response :json, :content_type => /\bjson$/
        f.adapter  Faraday.default_adapter
      end

      # Remember the query.
      @query = query

      # Get the raw data.
      @results = perform!(query)

      # Turn that data into something a Citation class can understand.
      @results = format!(@results)

      self
    end

    # Return as hash.
    def to_hash
      hash = {}

      instance_variables.each do |v|
        hash[v.to_s[1..-1].to_sym] = instance_variable_get(v)
      end

      hash[:results].each do |c|
        hash[:results][hash[:results].index(c)] = c.to_hash
      end

      hash
    end

    private

    def perform!(query)
      request = @@connection.get do |r|
        r.url "/books/v1/volumes", :q => query
      end

      request.body
    end

    def format!(hash)
      arr = []

      hash["items"].each do |i|
        vol = i["volumeInfo"]

        authors = vol["authors"]

        contributors = []
        authors.each do |a|
          contributors << Scholar::Utilities::Contributor.new(a).attributes
        end

        citation = Scholar::Citation.new({
          :type => :book,
          :contributors => contributors,
          :title => vol["title"],
          :publisher => vol["publisher"],
          :year => vol["publishedDate"][0,4]
        })

        arr << citation
      end

      arr
    end
  end
end
