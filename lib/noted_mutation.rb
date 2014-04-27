class NotedMutation < Mutations::Command
  def mongoid_errors!(obj)
    return if obj.nil?

    if obj.errors.any?
      obj.error.each do |field, message|
        klass = obj.class.name.downcase

        self.add_error("#{klass}.#{field}", :validation_error, message)
      end
    end
  end
end
