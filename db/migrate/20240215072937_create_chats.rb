class CreateChats < ActiveRecord::Migration[6.1]
  def change
    create_table :chats do |t|
      t.integer :admin_id, null: false
      t.integer :user_id, null: false
      t.integer :room_id, null: false
      t.text :message, null: false

      t.timestamps
    end
  end
end
