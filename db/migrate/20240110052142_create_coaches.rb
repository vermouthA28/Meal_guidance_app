class CreateCoaches < ActiveRecord::Migration[6.1]
  def change
    create_table :coaches do |t|
      t.integer :user_id, null: false
      t.integer :dietician_id, null: false

      t.timestamps
    end
  end
end
