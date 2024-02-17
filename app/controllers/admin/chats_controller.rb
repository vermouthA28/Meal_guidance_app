class Admin::ChatsController < ApplicationController
  before_action :block_non_related_users, only: [:show]

  # チャットルームの表示
  def show
    @admin = current_admin
    @user = current_admin.users.find_by(id: params[:id])
    rooms = @user.user_rooms.pluck(:room_id) #ログイン中のユーザーの部屋情報を全て取得
    user_rooms = UserRoom.find_by(admin_id: @admin.id, user_id: @user.id, room_id: rooms)#その中にチャットする相手とのルームがあるか確認
    unless user_rooms.nil?#ユーザールームがある場合
      @room = user_rooms.room#変数@roomにユーザー（自分と相手）と紐づいているroomを代入
    else#ユーザールームが無かった場合
      @room = Room.new#新しくRoomを作る
      @room.save#そして保存
      UserRoom.create(admin_id: @admin.id, user_id: current_user.id, room_id: @room.id)#自分の中間テーブルを作成
    end
    @chats = @room.chats#チャットの一覧
    @chat = Chat.new(room_id: @room.id)#チャットの投稿
  end

  # チャットメッセージの送信
  def create
    @user = current_admin.users.find_by(id: params[:id])
    @chat = current_admin.chats.new(chat_params)
    @chat.user_id = @chat.room.user_rooms.find_by(admin_id: current_admin.id).user_id
    @chat.save
    @room = @chat.room
    @chats = @room.chats
    render :validate unless @chat.save
  end

   # チャットメッセージの削除
  def destroy
    @user = current_admin.users.find_by(id: params[:id])
    @chat = current_admin.chats.find_by(id: params[:id], admin_id: current_admin.id)
    if @chat
      @chat.destroy
      redirect_to admin_chat_path(@chat)
    else
      # チャットが見つからない場合の処理
      flash[:alert] = "指定されたチャットが見つかりませんでした。"
      redirect_to admin_users_path # または適切なリダイレクト先
    end
  end

  private
  def chat_params
    params.require(:chat).permit(:message, :room_id)
  end

  def block_non_related_users # チャット相手のユーザーを取得
    @user = current_admin.users.find_by(id: params[:id])
  end
end



