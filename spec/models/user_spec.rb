require 'rails_helper'

RSpec.describe User, type: :model do
  it 'has a valid factory' do
    expect(build(:user)).to be_valid
  end

  it { should have_one :profile }
  it { should have_many :social_profiles }
  it { should have_many :courses }
  it { should have_many :course_users }
  it { should have_many :participated_courses }

  it { should accept_nested_attributes_for :profile }

  describe '#full_name' do
    let(:user) { create :user }
    let!(:profile) { create(:profile, user: user, first_name: 'John', last_name: 'Smit') }

    it 'should return user full name' do
      expect(user.full_name).to eq('John Smit')
    end
  end

  describe '#participate_in?' do
    let(:user) { create :user }
    let!(:course) { create(:course) }

    it 'should check participation in course' do
      course.participants << user
      expect(user.participate_in?(course)).to eq(true)
    end
  end

  describe '#expelled?' do
    let(:expelled_course_user) { create(:expelled_course_user) }
    let(:course_user) { create(:course_user) }

    it 'should return true if User is expelled' do
      expect(expelled_course_user.user.expelled?(expelled_course_user.course)).to eq(true)
    end
    it 'should return false if User is expelled' do
      expect(course_user.user.expelled?(course_user.course)).to eq(false)
    end
  end
end
