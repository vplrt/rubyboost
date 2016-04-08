class CommentsController < ApplicationController
  before_action :find_comment, only: :destroy
  authorize_resource

  def create
    @comment = current_user.comments.build(permitted_params)
    @comment.commentable = parent

    if @comment.save
      flash.now[:success] = 'Comment was succesfully saved'
    else
      render :new
    end
  end

  def destroy
    @comment.destroy
  end

  private

  def find_comment
    @comment = Comment.find(params[:id])
  end

  def parent
    @parent ||=
      if params[:lesson_id].present?
        Lesson.find(params[:lesson_id])
      elsif params[:homework_id].present?
        Homework.find(params[:homework_id])
      end
  end

  helper_method :parent

  def permitted_params
    params.require(:comment).permit(:body)
  end
end
