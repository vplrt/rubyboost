require 'rails_helper'

RSpec.describe Activity, type: :model do
  it 'has a valid factory' do
    expect(build(:activity)).to be_valid
  end

  it { should belong_to :recipient }
  it { should belong_to :owner }
  it { should belong_to :trackable }

  describe '#recent' do
    let!(:activity_1) { create :activity }
    let!(:activity_2) { create :activity }

    it 'should order activities by created_at :desc' do
      expect(Activity.recent.to_a).to eq([activity_2, activity_1])
    end
  end
end
