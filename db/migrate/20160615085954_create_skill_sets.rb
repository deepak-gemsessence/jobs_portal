class CreateSkillSets < ActiveRecord::Migration
  def change
    create_table :skill_sets do |t|
      t.integer :skillable_id
      t.string :skillable_type
      t.integer :skill_id

      t.timestamps null: false
    end
  end
end
