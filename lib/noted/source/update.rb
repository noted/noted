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

    return add_error(:current_user, :unauthorized, 'not authorized') unless current_user.can_update?(s)

    s.update_attributes(self.source)

    s.updater = current_user

    s.save

    ActionController::Base.new.expire_fragment(p)

    return s
  end
end
