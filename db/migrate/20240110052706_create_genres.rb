class CreateGenres < ActiveRecord::Migration[6.1]
  def change
    create_table :genres do |t|
      t.string :breakfast, null: false
      t.string :lunch, null: false
      t.string :dinner, null: false
      t.string :snack, null: false

      t.timestamps
    end
  end
end
