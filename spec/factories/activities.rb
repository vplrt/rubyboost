FactoryGirl.define do
  factory :activity do
    owner_id { create(:user) }
    recipient_id { create(:user) }
    kind Activity::KIND_LESSON_MATERIALS_UPLOADED
    trackable { create(:lesson) }
    message 'New activity'
  end
end
