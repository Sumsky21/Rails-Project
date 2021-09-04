class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.references :item, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.references :address, null: false, foreign_key: true
      t.integer :num
      t.text :remark
      t.integer :EMS_code
      t.integer :state

      t.timestamps
    end
  end
end
