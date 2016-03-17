class Homework < ActiveRecord::Base
  belongs_to :user
  belongs_to :lesson

  validates :body, presence: true
  validates :user_id, uniqueness: { scope: :lesson_id, allow_blank: false }
end
