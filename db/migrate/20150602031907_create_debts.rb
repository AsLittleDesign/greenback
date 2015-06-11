class CreateDebts < ActiveRecord::Migration
  def change
    create_table :debts do |t|
      t.string :name
      t.integer :owner_id
      t.integer :amount
      t.integer :interest
      t.integer :minimum_payment
      t.string :duration
      t.string :description

      t.timestamps null: false
    end
  end
end
