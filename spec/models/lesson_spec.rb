require 'rails_helper'

RSpec.describe Lesson, type: :model do
  it 'has a valid factory' do
    expect(build(:lesson)).to be_valid
  end

  it { is_expected.to validate_presence_of :title }
  it { is_expected.to validate_length_of(:title).is_at_most(100) }
  it { is_expected.to validate_presence_of :description }
  it { is_expected.to validate_presence_of :position }

  it { should belong_to :user }
  it { should belong_to :course }

  describe '#by_position' do
    let!(:lesson_1) { create :lesson, position: 1 }
    let!(:lesson_2) { create :lesson, position: 2 }

    it 'should order courses by position ASC' do
      expect(Lesson.by_position.to_a).to eq([lesson_1, lesson_2])
    end
  end
end
