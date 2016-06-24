class CreateAppliedJobs < ActiveRecord::Migration
  def change
    create_table :applied_jobs do |t|
      t.integer :job_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
