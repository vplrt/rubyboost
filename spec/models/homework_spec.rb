require 'rails_helper'

RSpec.describe Homework, type: :model do
  it 'has a valid factory' do
    expect(build(:homework)).to be_valid
  end

  it { is_expected.to validate_presence_of :body }
  it { is_expected.to validate_uniqueness_of(:user_id).scoped_to(:lesson_id) }

  it { should belong_to :user }
  it { should belong_to :lesson }

  it { should have_many :activities }

  describe '#state' do
    let(:homework) { create :homework }

    it 'has initial state: pending' do
      expect(homework.pending?).to eq true
    end

    it 'approve! changes state from pending to approved' do
      homework.approve!
      expect(homework.approved?).to eq true
    end

    it 'approve! creates new activity feed' do
      expect { homework.approve! }.to change(Activity, :count).by(1)
    end

    it 'reject! changes state from pending to rejected' do
      homework.reject!
      expect(homework.rejected?).to eq true
    end

    it 'reject! creates new activity feed' do
      expect { homework.reject! }.to change(Activity, :count).by(1)
    end
  end
end
