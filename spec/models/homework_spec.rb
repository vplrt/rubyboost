require 'rails_helper'

RSpec.describe Homework, type: :model do
  it 'has a valid factory' do
    expect(build(:homework)).to be_valid
  end

  it { is_expected.to validate_presence_of :body }
  it { is_expected.to validate_uniqueness_of(:user_id).scoped_to(:lesson_id) }

  it { should belong_to :user }
  it { should belong_to :lesson }
end
