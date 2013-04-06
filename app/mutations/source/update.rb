class Source
  class Update < Mutations::Command
    required do
      string :author

      hash :source do
        string :id

        model :attributes, class: Hash
      end
    end

    def execute
      s = Source.find(source[:id])

      s.citation = Scholar::Citation.new(attributes!(source[:attributes]))

      a = User.find(author)

      s.updater = a
      s.project.updater = a

      s.save

      s
    end

    def attributes!(hash)
      contributors_raw = hash["contributors"]
      hash.delete("contributors")

      contributors = []
      contributors_raw.each do |k, v|
        contributors << v.symbolize_keys
      end

      hash = hash.symbolize_keys
      hash[:contributors] = contributors

      hash
    end
  end
end
