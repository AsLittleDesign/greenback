class ChangeAmountColumnNameInBills < ActiveRecord::Migration
  def change
  	change_table :bills do |t|
  	  t.rename :amout, :amount
  	end
  end
end
