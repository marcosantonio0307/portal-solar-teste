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
    end

    add_index :power_generators, :uuid, unique: true
    add_index :power_generators, :power
  end
end
