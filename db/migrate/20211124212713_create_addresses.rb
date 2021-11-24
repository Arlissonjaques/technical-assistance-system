class CreateAddresses < ActiveRecord::Migration[6.1]
  def change
    create_table :addresses do |t|
      t.string :street
      t.string :district
      t.integer :number
      t.string :complement

      t.timestamps
    end
  end
end
