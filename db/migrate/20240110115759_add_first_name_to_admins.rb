class AddFirstNameToAdmins < ActiveRecord::Migration[6.1]
  def change
    add_column :admins, :first_name, :string
  end
end
