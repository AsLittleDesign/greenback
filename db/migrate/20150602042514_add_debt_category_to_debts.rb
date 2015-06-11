class AddDebtCategoryToDebts < ActiveRecord::Migration
  def change
  	add_column :debts, :debt_category, :string
  end
end
