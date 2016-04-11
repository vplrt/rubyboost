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

  it { should have_many :activities }
  it { should have_many :comments }

  describe '#by_position' do
    let!(:lesson_1) { create :lesson, position: 1 }
    let!(:lesson_2) { create :lesson, position: 2 }

    it 'should order courses by position ASC' do
      expect(Lesson.by_position.to_a).to eq([lesson_1, lesson_2])
    end
  end

  describe '#state' do
    let(:user) { create :user }
    let(:lesson) { create :lesson }

    it 'has initial state: pending_conduction' do
      expect(lesson.pending_conduction?).to eq true
    end

    it 'conduct_lesson changes state to pending_for_materials' do
      lesson.conduct_lesson!
      expect(lesson.pending_for_materials?).to eq true
    end

    it 'send_materials changes state from pending_for_materials to materials_uploaded' do
      lesson.conduct_lesson!
      lesson.send_materials!
      expect(lesson.materials_uploaded?).to eq true
    end
  end
end
