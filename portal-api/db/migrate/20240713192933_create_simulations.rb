class CreateSimulations < ActiveRecord::Migration[6.1]
  def change
    create_table :simulations do |t|
      t.references :customer, null: false, foreign_key: true

      t.float :electricity_bill, null: false
      t.float :power
      t.timestamps
    end
  end
end
