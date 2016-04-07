class ManageUserSubscriptionsService
  class Result
    include SimpleServiceResult
  end

  def initialize(course, user)
    @course = course
    @user = user
  end

  def self.subscribe(*args)
    new(*args).subscribe
  end

  def self.unsubscribe(*args)
    new(*args).unsubscribe
  end

  def subscribe
    return expelled_error if @user.expelled?(@course)
    return subscribed_error if @user.participate_in?(@course)
    return email_error unless @user.email.present?

    @course.participants << @user

    Result.new true, 'Successfully subscribed!', 200
  end

  def unsubscribe
    return unsubscribed_error unless @user.participate_in?(@course)
    return expelled_error if @user.expelled?(@course)

    course_user.destroy
    Result.new true, 'Successfully unsubscribed!', 200
  end

  private

  def course_user
    @course.course_users.where(user_id: @user.id).first
  end

  def unsubscribed_error
    Result.new false, 'Can\'t unsubscribe. You didn\'t subscribed.', 422
  end

  def expelled_error
    Result.new false, 'Can\'t perform. You have been expelled from course!', 422
  end

  def email_error
    Result.new false, 'Please fill in your email and password, before.', 422
  end

  def subscribed_error
    Result.new false, 'Can\'t subscribe. You have already subscribed.', 422
  end
end
