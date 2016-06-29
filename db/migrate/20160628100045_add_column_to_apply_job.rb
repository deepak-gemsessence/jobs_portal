class AddColumnToApplyJob < ActiveRecord::Migration
  def change
    add_column :apply_jobs, :status, :string
  end
end
