# rubocop: disable Metrics/AbcSize
class Ability
  include CanCan::Ability

  def initialize(user)
    if user.present?
      user.has_role?(:coach) ? coach_abilities(user) : user_abilities(user)
    else
      guest_abilities
    end
  end

  def guest_abilities
    can :read, [Course]
  end

  def user_abilities(user)
    guest_abilities

    can :read, :dashboard

    can :read, Lesson do |lesson|
      !user.expelled?(lesson.course) && lesson.course.participants.pluck(:id).include?(user.id)
    end

    can :manage, [Profile, Homework], user_id: user.id

    can [:subscribe, :unsubscribe], CourseUser do |course_user|
      !user.expelled?(course_user.course)
    end
  end

  def coach_abilities(user)
    user_abilities(user)

    can :expel, CourseUser do |course_user|
      course_user.course.user_id == user.id
    end

    can :manage, [Course, Lesson], user_id: user.id
  end
end