require 'rails_helper'

RSpec.describe Course, type: :model do
  it 'has a valid factory' do
    expect(build(:course)).to be_valid
  end

  it { is_expected.to validate_presence_of :title }
  it { is_expected.to validate_length_of(:title).is_at_most(100) }

  describe '#recent' do
    let!(:course_1) { create :course }
    let!(:course_2) { create :course }

    it 'should order courses by created_at DESC' do
      expect(Course.recent.to_a).to eq([course_2, course_1])
    end
  end

  describe '#visible' do
    let!(:course_1) { create :course }
    let!(:course_2) { create :course, visible: false }

    it 'should return only visible course' do
      expect(Course.visible.to_a).to eq([course_1])
    end
  end
end
