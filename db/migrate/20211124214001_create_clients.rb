class CreateClients < ActiveRecord::Migration[6.1]
  def change
    create_table :clients do |t|
      t.string :full_name
      t.string :cpf
      t.references :address, null: false, foreign_key: true

      t.timestamps
    end
  end
end
