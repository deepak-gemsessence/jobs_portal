class Rating < ActiveRecord::Base
  belongs_to :user
  belongs_to :job
  enum category: {quality: 0, salary: 1, location: 2, time: 3}

  def self.categories(job, user, category)
    where(job_id: job, user_id: user, category: category).last.star if self.where(job_id: job, user_id: user, category: category).present?
  end

end