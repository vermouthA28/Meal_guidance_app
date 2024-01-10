class CreatePosts < ActiveRecord::Migration[6.1]
  

  def change
    create_table :posts do |t|
      t.integer :genre_id, null: false
      t.datetime :eaten_at, null: false
      t.text :meal_content, null: false

      t.timestamps
    end
  end
end
