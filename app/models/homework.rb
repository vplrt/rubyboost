class Homework < ActiveRecord::Base
  include AASM

  belongs_to :user
  belongs_to :lesson

  validates :body, presence: true
  validates :user_id, uniqueness: { scope: :lesson_id, allow_blank: false }

  aasm column: :state do
    state :pending, initial: true
    state :approved
    state :rejected

    event :approve do
      transitions from: :pending, to: :approved
    end

    event :reject do
      transitions from: :pending, to: :rejected
    end
  end
end
