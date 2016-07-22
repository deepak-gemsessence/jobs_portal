class RatingsController < ApplicationController

  before_action :job_id, only: [:create]

  def create
    binding.pry
    # @rating = Rating.new(star: params[:quality_star], category: 'quality', job_id: params[:job_id], user_id: current_user.id)

    # http://stackoverflow.com/questions/18747062/rails-create-or-update-magic
    # http://stackoverflow.com/questions/23713674/check-if-record-exist-if-yes-update-else-create-new-nested-forms-rails

    quality = 'quality' if params[:quality_star].present?
    salary = 'salary' if params[:salary_star].present?
    location = 'location' if params[:location_star].present?
    time = 'time' if params[:time_star].present?

    Rating.new(star: params[:quality_star], category: 'quality', job_id: @job, user_id: current_user.id) if quality.present?

  #   # @rating = Rating.new(permit_params)
    redirect_to root_path
  end

  private

  def permit_params
    params.require(:job).permit(comments_attributes: [:id, :job_id, :user_id, :star, :category])
    # params.require(:rating).permit(:job_id, :user_id, :star, :category)
  end

  def job_id
    @job = Job.find(params[:job_id])
  end

end
