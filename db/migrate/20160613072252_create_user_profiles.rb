class CreateUserProfiles < ActiveRecord::Migration
  def change
    create_table :user_profiles do |t|
      t.string :graduation
      t.string :post_graduation
      t.string :contact
      t.string :address
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
