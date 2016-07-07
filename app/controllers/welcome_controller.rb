class WelcomeController < ApplicationController
  def index
    @jobs = Job.all.expired_jobs.page(params[:page]).per(3) if current_user.seeker?
  end

  def new
  end
end
