require 'rails_helper'

RSpec.describe CourseUser, type: :model do
  let(:user) { create :user }
  let!(:course_user) { create :course_user, user: user }

  it 'has a valid factory' do
    expect(build(:course_user)).to be_valid
  end

  it 'creates new activity feed after_commit on create' do
    expect { create(:course_user) }.to change(Activity, :count).by(1)
  end

  it 'creates activity feed after_commit on destroy' do
    expect { course_user.destroy }.to change(Activity, :count).by(1)
  end

  describe '#expel!' do
    it 'should update expelled attribute to true' do
      course_user.expel!
      expect(user.expelled?(course_user.course)).to eq(true)
    end

    it 'creates new activity' do
      expect { course_user.expel! }.to change(Activity, :count).by(1)
    end
  end
end
