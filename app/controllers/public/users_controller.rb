class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  def show
    @user = User.find(params[:id])

  end

  def edit
  end

  def confirm_withdraw
  end

  private
   def ensure_guest_user
    @user = User.find(params[:id])
    if @user.guest_user?
    redirect_to user_path(current_user) , notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
   end
end
