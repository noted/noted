class Source
  class Create < Mutations::Command
    required do
      string :project
      string :author

      hash :source do
        model :attributes, class: Hash
      end
    end

    def execute
      s = Source.new(
        :creator => User.find(author)
      )

      s.citation = Scholar::Citation.new(attributes!(source[:attributes]))

      Project.find(project).sources << s

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
