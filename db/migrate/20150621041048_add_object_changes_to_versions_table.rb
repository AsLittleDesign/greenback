class AddObjectChangesToVersionsTable < ActiveRecord::Migration
  def change
    add_column :budget_versions, :object_changes, :text
  end
end
