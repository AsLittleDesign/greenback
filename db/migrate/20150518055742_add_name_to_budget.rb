class AddNameToBudget < ActiveRecord::Migration
  def change
    add_column :budgets, :name, :string
  end
end
