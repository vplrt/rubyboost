require 'rails_helper'

feature 'Activity feed' do
  given(:recepient) { create(:user) }
  given(:owner) { create(:user) }
  given!(:activity) { create(:activity, recipient_id: recepient.id, owner_id: owner.id) }

  background do
    signin(recepient.email, recepient.password)
  end

  scenario 'Recepient can see his activity feed' do
    visit users_activities_path
    expect(page).to have_content activity.message
  end
end
