require 'rails_helper'

RSpec.describe Role, type: :model do
  context 'coach' do
    let(:user) { create(:user) }
    before { user.add_role(:coach) }

    specify do
      expect(user).to have_role(:coach)
    end

    specify do
      user.remove_role(:coach)
      expect(user).to_not have_role(:coach)
    end
  end
end
