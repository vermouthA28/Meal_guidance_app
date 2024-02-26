class Chat < ApplicationRecord

  belongs_to :admin, optional: true
  belongs_to :user, optional: true
  belongs_to :room
  has_one :notification, as: :notifiable, dependent: :destroy

  validates :message, presence: true, length: { maximum: 140 }

  after_create do
    if self.user_id.nil? #ユーザーが受け取った場合
      create_notification(user_id: self.room.user_rooms.first.user.id)
    elsif self.admin_id.nil? #ユーザーが送信した場合
      create_notification(admin_id: self.room.user_rooms.first.admin.id)
    end
  end
end

## notifications.where(user_id: current_admin.users.ids).each do