class Course < ActiveRecord::Base
  validates :title, presence: true, length: { maximum: 100 }

  scope :recent, -> { order(created_at: :desc) }
end
