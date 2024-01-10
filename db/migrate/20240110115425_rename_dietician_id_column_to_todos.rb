class RenameDieticianIdColumnToTodos < ActiveRecord::Migration[6.1]
  def change
    rename_column :todos, :dietician_id, :admin_id
  end
end
