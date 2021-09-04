class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.string :recipient
      t.string :district
      t.text :details
      t.integer :postal_code
      t.integer :phone_number
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
