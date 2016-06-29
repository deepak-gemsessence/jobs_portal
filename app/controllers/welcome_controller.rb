class WelcomeController < ApplicationController
  def index
    # @jobs = Job.all.where(recruiter_id: current_user.id)
    @jobs = Job.all.expired_jobs if current_user.seeker?
  end

  def new
  end

  def messages
    redirect_to root_path
  end
end
