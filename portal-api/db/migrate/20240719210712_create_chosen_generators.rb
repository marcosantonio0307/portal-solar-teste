class CreateChosenGenerators < ActiveRecord::Migration[6.1]
  def change
    create_table :chosen_generators do |t|
      t.references :simulation, null: false, foreign_key: true
      t.string :uuid, null: false
      t.string :name, null: false
      t.integer :price, null: false
      t.integer :panels, null: false
      t.float :power, null: false
      t.string :image_url, null: false

      t.timestamps
    end
  end
end
