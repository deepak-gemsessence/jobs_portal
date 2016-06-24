class JobsController < ApplicationController

  before_action :get_job_id, only: [:show, :update, :edit, :destroy, :apply, :un_apply]
  before_action :all_skills, only: [:new, :create]

  def index
    if params[:search].present?# || params[:skills].present?
      @jobs = Job.search(params[:search]).order("created_at DESC")
      # @jobs = Job.joins(:skills).where(['(jobs.title) like ? or (skills.name) like ?', "%#{params[:title]}%", "%#{params[:name]}%"]).distinct #if current_user.recruiter?
    else
      if current_user.seeker?
        # user_skills = current_user.skills.ids
        # jobs = []
        # Job.all.each do |jb|
        #   job_skills = jb.skills.ids
        #   job_skill_present = job_skills.all?{|skill| user_skills.include?(skill)}
        #   user_skill_present = user_skills.all?{|skill| job_skills.include?(skill)}
        #   jobs << jb if user_skill_present || job_skill_present
        # end
        jobs = Job.joins(:skill_sets).where('skill_sets.skill_id IN (?)', current_user.skills.map(&:id)).uniq
        if current_user.skills.present?
          @jobs = jobs
        else
          flash.now[:error] = "You don't have any skill, You are being redirected on 'Home Page'"
            # render action: :index
          redirect_to root_path
        end
      else
        @jobs = Job.all.where(recruiter_id: current_user.id)
      end
    end

  end

  def new
    if current_user.recruiter?
      @job = current_user.jobs.new
      build_skills
    else
      flash[:error] = "You are not authorized add new job."
      redirect_to root_path
    end
  end

  def create
    @job = current_user.jobs.new(validate_params)
    if @job.save
      flash[:success] = "Job created successfully !!!"
      redirect_to jobs_path
    else
      @skills.each do |skill|
        @job.skill_sets.build(skill_id: skill.id) if !@job.skill_sets.map(&:skill_id).include? skill.id
      end
      render 'new'
    end
  end

  def show
    @job_seekers = @job.job_seekers
  end

  def edit
    unless current_user.recruiter?
      flash[:error] = "You are not authorized to edit this job."
      redirect_to root_path
    end
  end

  def update
    if @job.update(validate_params)
      redirect_to @job
    else
      flash[:error] = "invalid details"
      render 'edit'
    end
  end

  def destroy
    if @job.match_recruiter(current_user)
      @job.destroy
      flash[:notice] = "You have successfully deleted job."
      redirect_to root_path
    else
      redirect_to jobs_path
    end
  end

  def apply
    respond_to do |format|
      @job.apply_jobs.create(user_id: current_user.id)
      format.html { redirect_to jobs_path }
      format.js {}
    end
  end

  def un_apply
    respond_to do |format|
      # binding.pry
       Job.find(params[:id]).apply_jobs.destroy_all
      # @job.apply_jobs.create(user_id: current_user.id)
      format.html { redirect_to jobs_path }
      format.js {}
    end
  end

  private

  def validate_params
    params.require(:job).permit(:title, :location, :expire_time, :min_salary, :max_salary, :description, skill_sets_attributes: [:id, :skill_id])
  end

  def get_job_id
    @job = Job.find(params[:id])
  end

  def build_skills
    @skills.each do |skill|
      @job.skill_sets.build(skill_id: skill.id)
    end
  end

  def all_skills
    @skills = Skill.all
  end

end
