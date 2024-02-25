class Chat < ApplicationRecord

  belongs_to :admin,optional: true
  belongs_to :user,optional: true
  belongs_to :room
  has_one :notification, as: :notifiable, dependent: :destroy

  validates :message, presence: true, length: { maximum: 140 }

  after_create do
    #ユーザーが受け取った場合
    create_notification(user_id: self.room.user_rooms.first.user.id)
    #ユーザーが送信した場合
    #user_id: self.user.id
  end
end

## notifications.where(user_id: current_admin.users.ids).each do 