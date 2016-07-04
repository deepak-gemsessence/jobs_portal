class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :apply_job_id

      t.timestamps null: false
    end
  end
end
