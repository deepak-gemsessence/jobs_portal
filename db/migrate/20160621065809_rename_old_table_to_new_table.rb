class RenameOldTableToNewTable < ActiveRecord::Migration
  def change
    rename_table :applied_jobs , :apply_jobs
  end
end
