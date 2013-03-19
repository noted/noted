# Create a Source with included Citation.
class Source
  class Create < Mutations::Command
    required do
      model :attributes, class: Hash
      model :author, class: BSON::ObjectId
      model :project, class: BSON::ObjectId
    end

    def execute
      s = Source.new
      s.citation = Scholar::Citation.new(attributes)
      s.creator = User.find(author)
      s.save

      p = Project.find(project)
      p.sources << s

      s
    end
  end
end
