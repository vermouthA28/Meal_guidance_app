class CreatePostTodos < ActiveRecord::Migration[6.1]
  def change
    create_table :post_todos do |t|
      t.references :post, null: false, foreign_key: true
      t.references :todo, null: false, foreign_key: true

      t.timestamps
    end
  end
end
