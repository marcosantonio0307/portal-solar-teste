class CreatePowerGenerators < ActiveRecord::Migration[6.1]
  def change
    create_table :power_generators do |t|
      t.string :uuid, null: false
      t.string :name, null: false
      t.integer :price, null: false
      t.integer :panels, null: false
      t.float :power, null: false
      t.string :image_url, null: false

      t.timestamps

      t.index :uuid, unique: true
    end
  end
end
