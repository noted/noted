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
        :citation => Scholar::Citation.new(source[:attributes]),
        :creator => User.find(author)
      )

      Project.find(project).sources << s

      s.save

      s
    end
  end
end
