class Notification < ApplicationRecord
  include Rails.application.routes.url_helpers

  belongs_to :user
  belongs_to :notifiable, polymorphic: true

  def message
     if notifiable_type === "Post"
      "#{notifiable.admin.last_name}栄養士が#{notifiable.comment}を投稿しました"
    else
      "#{notifiable.admin.last_name}が#{notifiable.user.name}さんにDMを送信しました"
    end
  end

  def notifiable_path
    if notification.notifiable_type === "Post"
      post_path(post)
    else
      chat_path(notifiable.user.id)
    end
  end


end
