class AddNullConstraintsToUser < ActiveRecord::Migration[6.1]
  def change
    change_column_null :user, :last_name, false
    change_column_null :user, :first_name, false
    change_column_null :user, :admin_id, false
  end
end
