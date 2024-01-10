class AddFirstNameToAdmins < ActiveRecord::Migration[6.1]
  def change
    add_column :admins, :first_name, :string, null: false
  end
end
