class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :title
      t.string :location
      t.datetime :expire_time
      t.integer :min_salary
      t.integer :max_salary
      t.text :description
      t.integer :recruiter_id
      t.timestamps null: false
    end
  end
end
