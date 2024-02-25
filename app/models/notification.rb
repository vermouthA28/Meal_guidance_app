class Notification < ApplicationRecord
  include Rails.application.routes.url_helpers

  belongs_to :user
  belongs_to :notifiable, polymorphic: true

  def message
     if notifiable_type === "Comment"
      "#{notifiable.admin.last_name}栄養士が#{notifiable.comment}を投稿しました"
    else
      "#{notifiable.admin.last_name}栄養士が#{user.last_name}さんにDMを送信しました"
    end
  end

  def notifiable_path
    if notifiable_type === "Comment"
      post_path(notifiable.post)
    else
      chat_path(user.id)
    end
  end
end
