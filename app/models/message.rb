class Message < ActiveRecord::Base
  belongs_to :apply_job
  has_one :job, through: :apply_job

  def apply_job_status
    if self.apply_job.is_declined?
      if self.apply_job.choosen_other_user?
        "Your job '#{self.job.title}' has been declined. reason-> choosen another candidate"
      else
        "Your job '#{self.job.title}' has been declined. reason-> by un-known reasons"
      end
    elsif self.apply_job.is_accepted?
      "You have been selected for :- '#{self.job.title}'"
    end
  end

end
