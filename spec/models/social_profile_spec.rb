require 'rails_helper'

RSpec.describe SocialProfile, type: :model do
  it 'has a valid factory' do
    expect(build(:social_profile)).to be_valid
  end

  it { should belong_to :user }

  it { is_expected.to validate_presence_of :service_name }
  it { is_expected.to validate_presence_of :uid }
  it { should validate_uniqueness_of(:service_name).scoped_to(:user_id) }
end
