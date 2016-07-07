class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  include Skillable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_one :user_profile, dependent: :destroy
  accepts_nested_attributes_for :user_profile
  has_many :skills, through: :skill_sets
  accepts_nested_attributes_for :skill_sets, allow_destroy: true
  has_many :apply_jobs, dependent: :destroy
  has_many :jobs, foreign_key: :recruiter_id, dependent: :destroy
  has_many :applied_jobs, through: :apply_jobs, source: :job
  has_many :messages, -> { where "status is not null" }, through: :apply_jobs
  has_many :comments, dependent: :destroy

  validates :username, uniqueness: true
  validates :first_name, :last_name, :username, presence: true

  enum user_type: {seeker: "Job-seeker", recruiter: "Job-recruiter"}

  GRAD = ['B.A.', 'B.B.A.', 'B.Com', 'B.C.A.', 'B.E.', 'B.Sc']
  POST_GRAD = ['M.A.', 'M.B.A.', 'M.Com', 'M.C.A.', 'M.E.', 'M.Sc']

  scope :recruiters, -> { where("user_type = 'Job-recruiter'") }

  def is_applied_job?(job)
    !(applied_jobs.where("job_id = ?", job.id)).present?
  end

end
