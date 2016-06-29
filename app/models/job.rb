require 'time'
class Job < ActiveRecord::Base
  has_many :skill_sets, as: :skillable
  has_many :skills, through: :skill_sets
  has_many :apply_jobs, dependent: :destroy
  has_many :job_seekers, through: :apply_jobs, source: :user
  belongs_to :recruiter, class_name: 'User'
  accepts_nested_attributes_for :skill_sets, allow_destroy: true

  validates :title, :location, :expire_time, :min_salary, :max_salary, :description, presence: true

  scope :filter_skills, -> (skills) { joins(:skill_sets).where('skill_sets.skill_id IN (?)', skills).uniq }
  scope :order_by_desc, -> {order(created_at: :DESC)}
  order_by_desc
  # scope :expired_jobs, -> { where(date(expire_time >= ) Date.today) }
  scope :expired_jobs, -> { where("date(expire_time) >= ?", Date.today) }

  def self.search(search)
    where("title like ?", "%#{search}%")
  end

  def match_recruiter(user)
    self.recruiter_id == user.id
  end

end
