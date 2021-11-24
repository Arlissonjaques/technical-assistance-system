class CreateDevices < ActiveRecord::Migration[6.1]
  def change
    create_table :devices do |t|
      t.string :name
      t.string :brand
      t.string :model
      t.references :device_type, null: false, foreign_key: true

      t.timestamps
    end
  end
end
