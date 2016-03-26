class ActivityDecorator < ApplicationDecorator
  delegate_all

  def partial_path
    object.trackable_type.underscore
  end

  def partial_name
    object.kind
  end
end
