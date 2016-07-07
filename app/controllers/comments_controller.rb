class CommentsController < ApplicationController

  before_action :job_id, only: [:create, :new]

  def new
    @parent_comment = Comment.find(params[:comment])
    respond_to do |format|
      format.js {}
    end
  end

  def create
    params[:comment].merge!(user_id: current_user.id)
    params[:comment].merge!(parent_id: @parent_comment.id) if @parent_comment.present?
    if @job.comments.create!(validate_comment_params)
      redirect_to @job
    end
  end

  private

  def validate_comment_params
    params.require(:comment).permit(:user_id, :parent_id, :body)
  end

  def job_id
    @job = Job.find(params[:job_id])
  end
end