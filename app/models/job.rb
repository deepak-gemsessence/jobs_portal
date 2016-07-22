require 'time'
class Job < ActiveRecord::Base
  include Skillable

  has_many :skills, through: :skill_sets
  has_many :apply_jobs, dependent: :destroy
  has_many :job_seekers, through: :apply_jobs, source: :user
  belongs_to :recruiter, class_name: 'User'
  accepts_nested_attributes_for :skill_sets, allow_destroy: true
  has_many :comments, dependent: :destroy
  has_many :ratings, dependent: :destroy
  accepts_nested_attributes_for :ratings, allow_destroy: true

  validates :title, :location, :expire_time, :min_salary, :max_salary, :description, presence: true

  scope :filter_skills, -> (skills) { joins(:skill_sets).where('skill_sets.skill_id IN (?)', skills).uniq }
  scope :order_by_desc, -> {order(created_at: :DESC)}
  order_by_desc
  scope :expired_jobs, -> { where("date(expire_time) >= ?", Date.today) }
  scope :apply_job_exists?, -> { where(apply_jobs.job_id is null) }

  # ratyrate_rateable "Quality", "Salary", "Location", "Time"


  def self.search(search)
     # by_skills = joins(:skills).where("skills.name like ?", "%#{search}%" )
     # by_title = where("title like ?", "%#{search}%")
     # by_skills.present? ? by_skills : by_title
    joins("inner join skill_sets ss on ss.skillable_id=jobs.id and ss.skillable_type='Job' left outer join skills s on s.id=ss.skill_id").where("name like '%#{search}%' or (title like '%#{search}%')")
  end

  def match_recruiter(user)
    self.recruiter_id == user.id
  end

end