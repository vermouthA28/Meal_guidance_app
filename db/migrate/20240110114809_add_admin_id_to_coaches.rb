class AddAdminIdToCoaches < ActiveRecord::Migration[6.1]
  def change
    add_column :coaches, :admin_id, :integer
  end
end
