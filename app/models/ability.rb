class Ability
  include CanCan::Ability

  def initialize(user)
    if user
      (user.has_role? :coach) ? coach_abilities(user) : user_abilities(user)
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
      lesson.course.participants.pluck(:id).include? user.id
    end

    can :manage, [Profile, Homework, CourseUser], user_id: user.id
  end

  def coach_abilities(user)
    user_abilities(user)

    can :manage, :course_expulsion do |course_user|
      course_user.user_id == user.id
    end

    can :manage, [Course, Lesson], user_id: user.id
  end
end
