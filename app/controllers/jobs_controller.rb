class JobsController < ApplicationController

  before_action :get_job_id, only: [:show, :update, :edit, :destroy, :apply, :un_apply, :decline]
  before_action :all_skills, only: [:new, :create]

  def index
    if params[:filter_by].present? && params[:search_key].present?
      @jobs = Job.search(params[:search_key]).order_by_desc & Job.filter_skills(params[:filter_by]).expired_jobs.page(params[:page]).per(3)
      respond_to do |format|
        format.js {}
      end
    elsif params[:filter_by].present?
      @jobs = Job.filter_skills(params[:filter_by]).expired_jobs.page(params[:page]).per(3)
      respond_to do |format|
        format.js {}
      end
    elsif params[:search].present?# || params[:skills].present?
      @jobs = Job.search(params[:search]).order_by_desc.expired_jobs.page(params[:page]).per(3)
      # @jobs = Job.joins(:skills).where(['(jobs.title) like ? or (skills.name) like ?', "%#{params[:title]}%", "%#{params[:name]}%"]).distinct #if current_user.recruiter?.page(params[:page]).per(3)
    else
      if current_user.seeker? && current_user.skills.present?
        @jobs = Job.filter_skills(current_user.skills.map(&:id)).expired_jobs.page(params[:page]).per(3)
      elsif current_user.seeker? && !current_user.skills.present?
        flash[:error] = "You don't have any skill, You are being redirected on 'Home Page'"
            # render action: :index
        redirect_to root_path
      else
        @jobs = Job.where(recruiter_id: current_user.id).page(params[:page]).per(3)
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
      apply_job = @job.apply_jobs.new(user_id: current_user.id)
      if apply_job.save
        apply_job.last.messages.create(apply_job_id: @job.apply_jobs.last.id)
      end
      format.html { redirect_to jobs_path }
      format.js {}
    end
  end

  def un_apply
    respond_to do |format|
       @job.apply_jobs.destroy_all
      format.html { redirect_to jobs_path }
      format.js {}
    end
  end

  def accept
    job = Job.find(params[:job_id])
    apply_job = job.apply_jobs.where(user_id: params[:seeker_id]).first
    apply_job.decline_other_jobs = params[:decline_all] if params[:decline_all]
    apply_job.update(status: "accepted")
    redirect_to jobs_path
  end

  def decline
    job = @job.apply_jobs.where(user_id: params[:job_seeker]).first
    job.update(status: "declined")
    redirect_to jobs_path
  end

  private

  def validate_params
    params.require(:job).permit(:title, :location, :expire_time, :min_salary, :max_salary, :description, skill_sets_attributes: [:id, :skill_id, :status])
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
