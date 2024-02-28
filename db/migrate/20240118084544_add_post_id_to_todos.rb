class AddPostIdToTodos < ActiveRecord::Migration[6.1]
  def change
    add_column :todos, :post_id, :integer, null: false
  end
end
