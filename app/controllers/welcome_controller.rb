class WelcomeController < ApplicationController
  def index
    # @jobs = Job.all.where(recruiter_id: current_user.id)
    @jobs = Job.all if current_user.seeker?
  end

  def new
  end
end
