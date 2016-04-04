require 'rails_helper'

RSpec.describe Comment, type: :model do
  it 'has a valid factory' do
    expect(build(:comment)).to be_valid
  end

  it { should belong_to :user }
  it { should belong_to :commentable }

  it { is_expected.to validate_presence_of :body }
end
