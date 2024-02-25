class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :admin
  has_one :notification, as: :notifiable, dependent: :destroy

  after_create do
    create_notification(user_id: post.user_id)
  end
end
