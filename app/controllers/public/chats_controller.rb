class Public::ChatsController < ApplicationController
  before_action :block_non_related_users, only: [:show]

  # チャットルームの表示
  def show
    @user = User.find(params[:id])
    @admin = User.find(@user.admin_id)
    rooms = current_user.user_rooms.pluck(:room_id) #ログイン中のユーザーの部屋情報を全て取得
    user_rooms = UserRoom.find_by(user_id: @user.id, room_id: rooms)#その中にチャットする相手とのルームがあるか確認

    unless user_rooms.nil?#ユーザールームがある場合
      @room = user_rooms.room#変数@roomにユーザー（自分と相手）と紐づいているroomを代入
    else#ユーザールームが無かった場合
      @room = Room.new#新しくRoomを作る
      @room.save#そして保存
      UserRoom.create(user_id: current_user.id, room_id: @room.id)#自分の中間テーブルを作成
      UserRoom.create(admin_id: @admin.id, room_id: @room.id)#相手の中間テーブルを作成
    end
    @chats = @room.chats#チャットの一覧
    @chat = Chat.new(room_id: @room.id)#チャットの投稿
  end

  # チャットメッセージの送信
  def create
    @chat = current_user.chats.new(chat_params)
    @room = @chat.room
    @chats = @room.chats
    render :validater unless @chat.save
  end

   # チャットメッセージの削除
  def destroy
    @chat = current_user.chats.find(params[:id])
    @chat.destroy
  end

  private
  def chat_params
    params.require(:chat).permit(:message, :room_id)
  end

  def block_non_related_users # チャット相手のユーザーを取得
    @user = User.find(params[:id])
  end
end

