class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.integer :user_id
      t.integer :job_id
      t.integer :star
      t.integer :category

      t.timestamps null: false
    end
  end
end
