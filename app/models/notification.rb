class Notification < ApplicationRecord
  include Rails.application.routes.url_helpers
  
  scope :admins_uniq_notifications, -> { where.not(admin_id: nil).map { |o| [o, Chat.find_by(id: o.notifiable_id).room.user_rooms
.first.user_id ] }.uniq { |o| o.last }.map { |o| o.first } } 

  belongs_to :user, optional: true
  belongs_to :admin, optional: true
  belongs_to :notifiable, polymorphic: true

  def message
    if self.user_id.nil?  # 管理者の場合
      chat = Chat.find_by(id: self.notifiable_id).room.user_rooms.first
      "#{chat.user.last_name}様が#{chat.admin.last_name}栄養士にDMを送信しました"
    else # ユーザーの場合
      if notifiable_type === "Comment"
        comment = Comment.find_by(id: self.notifiable_id)
        admin = comment.admin
        user = comment.post.user
        "#{admin.last_name}栄養士が#{user.last_name}様の投稿にコメントしました"
      elsif notifiable_type === "Chat"
        chat = Chat.find_by(id: self.notifiable_id).room.user_rooms.first
        "#{chat.admin.last_name}栄養士が#{chat.user.last_name}様にDMを送信しました"
      end
    end
  end


  def notifiable_path # 管理者の場合
    if self.user_id.nil? # 管理者の場合
      user = Chat.find_by(id: self.notifiable_id).room.user_rooms.first.user
      admin_chat_path(user)
    else # ユーザーの場合
      if notifiable_type === "Comment"
        post = Comment.find_by(id: self.notifiable_id).post
        post_path(post)
      else
        user = Chat.find_by(id: self.notifiable_id).room.user_rooms.first.user
        chat_path(user)
      end
    end
  end

end
