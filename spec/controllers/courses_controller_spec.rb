require 'rails_helper'

RSpec.describe CoursesController, type: :controller do
  let!(:course_1) { create :course }

  describe '#index' do
    let!(:course_2) { create :course }

    before { get :index }

    specify do
      expect(assigns(:courses)).to match_array [course_2, course_1]
    end
  end

  describe '#show' do
    before { get :show, id: course_1.id }

    it 'assings the requested course to @course' do
      expect(assigns(:course)).to eq course_1
    end
  end
end
