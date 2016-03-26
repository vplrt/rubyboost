class Activity < ActiveRecord::Base
  KIND_HOMEWORK_APPROVED = 'homework_approved'.freeze
  KIND_HOMEWORK_REJECTED = 'homework_rejected'.freeze
  KIND_LESSON_MATERIALS_UPLOADED = 'lesson_materials_uploaded'.freeze
  KIND_USER_SUBSCRIBED = 'user_subscribed'.freeze
  KIND_USER_UNSUBSCRIBED = 'user_unsubscribed'.freeze
  KIND_USER_EXPELLED = 'user_expelled'.freeze

  belongs_to :recipient, class_name: 'User', foreign_key: :recipient_id
  belongs_to :owner,     class_name: 'User', foreign_key: :owner_id
  belongs_to :trackable, polymorphic: true

  scope :recent, -> { order(created_at: :desc) }
end
