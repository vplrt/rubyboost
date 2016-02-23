require 'rails_helper'

RSpec.describe CoursesController, type: :controller do
  describe '#index' do
    let!(:course_1) { create :course }
    let!(:course_2) { create :course }

    before { get :index }

    specify do
      expect(assigns(:courses)).to match_array [course_2, course_1]
    end
  end
end
