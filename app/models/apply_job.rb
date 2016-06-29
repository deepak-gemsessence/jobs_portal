class ApplyJob < ActiveRecord::Base
  belongs_to :job
  belongs_to :user

  attr_accessor :decline_other_jobs

  after_save :decline_jobs

  scope :except_me, -> (id) { where.not('id = (?)', id) }
  scope :decline_all, -> {update_all(status: "declined")}
  scope :decline_all_apply_jobs_except_me, -> (id) { except_me(id).decline_all }

  def decline_jobs
    job = self.job
    if self.decline_other_jobs
      job.apply_jobs.decline_all_apply_jobs_except_me(self.id)
    end
  end

end
