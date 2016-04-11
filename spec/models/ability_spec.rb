require 'spec_helper'

describe Ability do
  subject(:ability) { Ability.new(user) }

  describe 'for guest' do
    let(:user) { nil }

    it { should be_able_to :read, Course }
    it { should_not be_able_to :read, :dashboard }
    it { should_not be_able_to :manage, :all }
  end

  describe 'for user' do
    let(:user) { create(:user) }
    let(:other) { create(:user) }

    it { should_not be_able_to :manage, :all }
    it { should be_able_to :read, Course }
    it { should be_able_to :read, Lesson }
    it { should be_able_to :read, :dashboard }
    it { should be_able_to :manage, create(:profile, user: user), user_id: user.id }
    it { should_not be_able_to :manage, create(:profile, user: other), user_id: user.id }
    it { should_not be_able_to [:create, :update, :destroy], Course }
    it { should_not be_able_to [:create, :update, :destroy], Lesson }
    it { should be_able_to :create, Homework }
    it { should be_able_to :read, Homework, user_id: user.id }
    it { should_not be_able_to :read, create(:homework, user: other), user_id: user.id }
    it { should_not be_able_to [:approve, :reject], Homework }
    it { should be_able_to :create, Comment }
    it { should be_able_to :destroy, Comment, user_id: user.id }
    it { should_not be_able_to :destroy, create(:comment, user: other), user_id: user.id }
  end

  describe 'for coach' do
    let(:user) { create(:coach) }
    let(:other) { create(:user) }

    it { should be_able_to :manage, create(:course, user: user), user_id: user.id }
    it { should_not be_able_to [:update, :destroy], create(:course, user: other), user_id: user.id }
    it { should be_able_to :manage, create(:lesson, user: user), user_id: user.id }
    it { should_not be_able_to [:update, :destroy], create(:lesson, user: other), user_id: user.id }
    it { should be_able_to :manage, create(:profile, user: user), user_id: user.id }
    it { should_not be_able_to [:update, :destroy], create(:profile, user: other), user_id: user.id }
    it { should be_able_to :read, :dashboard }
  end
end
