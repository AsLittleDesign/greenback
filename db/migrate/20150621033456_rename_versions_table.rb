class RenameVersionsTable < ActiveRecord::Migration
  def change
		rename_table :versions, :budget_versions
	end
end
