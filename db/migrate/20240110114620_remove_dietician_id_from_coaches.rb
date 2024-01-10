class RemoveDieticianIdFromCoaches < ActiveRecord::Migration[6.1]
  def change
    remove_column :coaches, :dietician_id, :integer
  end
end
