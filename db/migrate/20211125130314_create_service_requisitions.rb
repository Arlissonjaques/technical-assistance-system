class CreateServiceRequisitions < ActiveRecord::Migration[6.1]
  def change
    create_table :service_requisitions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :client, null: false, foreign_key: true
      t.boolean :others_withdraw, null: false, default: false
      t.references :device, null: false, foreign_key: true
      t.date :withdrawal_forecast
      t.date :delivery_forecast
      t.float :price
      t.text :comments
      t.string :status, null: false, default: 'OPEN'
      t.text :initial_problem
      t.string :device_photo
      t.string :signed_service_order
      t.text :reason_cancellation

      t.timestamps
    end
  end
end
