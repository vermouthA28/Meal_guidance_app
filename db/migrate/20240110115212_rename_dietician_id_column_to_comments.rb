class RenameDieticianIdColumnToComments < ActiveRecord::Migration[6.1]
  def change
    rename_column :comments, :dietician_id, :admin_id
  end
end
