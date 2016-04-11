class Homeworks::RejectService
  class Result
    include SimpleServiceResult
    attr_accessor :comment_for_reject

    def initialize(success, comment_for_reject)
      self.success, self.comment_for_reject = success, comment_for_reject
    end
  end

  def initialize(homework, user, body)
    @homework = homework
    @user = user
    @body = body
  end

  def self.perform(*args)
    new(*args).perform
  end

  def perform
    comment_for_reject = @user.comments.build(body: @body)

    Homework.transaction do
      if comment_for_reject.save
        @homework.reject!
        @homework.comments << comment_for_reject

        return Result.new true, comment_for_reject
      end
    end

    Result.new false, comment_for_reject
  end
end
