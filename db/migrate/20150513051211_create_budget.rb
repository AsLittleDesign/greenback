class CreateBudget < ActiveRecord::Migration
  def change
    create_table :budgets do |t|
      t.string :name
      t.integer :owner_id
      t.string :category
      t.integer :amout
      t.string :duration
      t.string :cycle_start
      t.string :description

      t.timestamps null: false
    end
  end
end
