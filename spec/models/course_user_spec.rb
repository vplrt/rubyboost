require 'rails_helper'

RSpec.describe CourseUser, type: :model do
  it 'has a valid factory' do
    expect(build(:course_user)).to be_valid
  end

  describe '#expel!' do
    let!(:course_user) { create :course_user }

    it 'should update expelled attribute to true' do
      expect(course_user.expel!).to eq(true)
    end
  end
end
