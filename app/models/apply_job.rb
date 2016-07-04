class ApplyJob < ActiveRecord::Base
  belongs_to :job
  belongs_to :user
  has_many :messages, dependent: :destroy

  attr_accessor :decline_other_jobs

  after_save :decline_jobs

  scope :except_me, -> (id) { where.not('id = (?)', id) }
  scope :decline_all, -> {update_all(status: "declined")}
  scope :decline_all_apply_jobs_except_me, -> (id) { except_me(id).decline_all }
  scope :accepted, -> { where(status: 'accepted') }
  scope :rejected, -> { where(status: 'declined') }

  def decline_jobs
    job = self.job
    if self.decline_other_jobs
      job.apply_jobs.decline_all_apply_jobs_except_me(self.id)
    end
  end

  def is_declined?
    status=='declined'
  end

  def is_accepted?
    status=='accepted'
  end

  def choosen_other_user?
    Job.find(self.job_id).apply_jobs.where("status = 'accepted'").present?
  end

end
