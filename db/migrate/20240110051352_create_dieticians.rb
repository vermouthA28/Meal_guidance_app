class CreateDieticians < ActiveRecord::Migration[6.1]
  def change
    create_table :dieticians do |t|
      t.string :last_name, null: false
      t.string :first_name, null: false
      t.string :email, null: false
      t.string :encrypted_password, null: false

      t.timestamps
    end
  end
end
