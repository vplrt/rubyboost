require 'rails_helper'

RSpec.describe Profile, type: :model do
  it 'has a valid factory' do
    expect(build(:profile)).to be_valid
  end

  it { should belong_to :user }

  it { is_expected.to validate_presence_of :first_name }
end
