class SourceUpdate < Mutations::Command
  required do
    model :source, class: BSON::ObjectId
    model :attributes, class: Hash
    model :author, class: BSON::ObjectId
  end

  def execute
    s = Source.find(source)
    s.citation = Scholar::Citation.new(attributes)
    s.updater = User.find(author)
    s.save

    s
  end
end
