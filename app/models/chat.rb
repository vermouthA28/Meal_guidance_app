class Chat < ApplicationRecord

  belongs_to :admin, optional: true
  belongs_to :user, optional: true
  belongs_to :room
  has_one :notification, as: :notifiable, dependent: :destroy

  validates :message, presence: true, length: { maximum: 140 }
  validate :required_either_admin_id_or_user_id

  after_create do
    if self.user_id.nil? #ユーザーが受け取った場合
      create_notification(user_id: self.room.user_rooms.first.user.id)
    elsif self.admin_id.nil? #ユーザーが送信した場合
      create_notification(admin_id: self.room.user_rooms.first.admin.id)
    end
  end

  private

  def required_either_admin_id_or_user_id
    # 演算子 ^ で排他的論理和（XOR）にしています
    # emailかphoneのどちらかの値があれば true
    # email、phoneどちらも入力されている場合や入力されていない場合は false
    return if admin_id.present? ^ user_id.present?

    errors.add(:base, 'エラーが出ました')
  end
end

## notifications.where(user_id: current_admin.users.ids).each do