class SourceDestroy < Mutations::Command
  required do
    model :current_user, class: User
    hash  :source do
      string :id
    end
  end

  def execute
    s = Source.find(self.source['id'])

    add_error(:current_user, :unauthorized, 'not authorized') unless current_user.can_destroy?(s)

    s.destroy

    return nil
  end
end
