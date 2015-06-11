class AddColumnsToBudget < ActiveRecord::Migration
  def change
    add_column :budgets, :amount, :integer
    add_column :budgets, :description, :string
  end
end
