class NotedMutation < Mutations::Command
  def mongoid_errors!(obj)
    return if obj.nil?

    if obj.errors.any?
      obj.errors.each do |field, message|
        klass = obj.class.name.downcase

        self.add_error("#{klass}.#{field}", :validation_error, "#{field.capitalize} #{message}")
      end
    end
  end
end
