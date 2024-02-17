class ChangeColumnToNull < ActiveRecord::Migration[6.1]
 
  
  def up
    # Not Null制約を外す場合　not nullを外したいカラム横にtrueを記載
    change_column_null :chats, :admin_id, true
    change_column_null :chats, :user_id, true
    change_column_null :user_rooms, :admin_id, true
    change_column_null :user_rooms, :user_id, true
  end
end
