class SourceUpdate < Mutations::Command
  required do
    model :current_user, class: User
    hash  :source do
      string :id
      model :information, class: Hash
    end
  end

  def execute
    s = Source.find(self.source['id'])

    add_error(:current_user, :unauthorized, 'not authorized') unless current_user.can_update?(s)

    s.update_attributes(self.source)
    s.save

    return s
  end
end
