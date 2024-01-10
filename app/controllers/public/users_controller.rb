class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  def show
    @user = User.find(params[:id])

  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path, notice: '会員情報の更新が完了しました。'
    else
      render :edit
    end
  end

  def confirm_withdraw
  end
  
  def withdraw
    @user = User.find(current_user.id)
    @user.update(is_active: false)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
   end

  private
    def ensure_guest_user
      @user = User.find(params[:id])
      if @user.guest_user?
      redirect_to user_path(current_user) , notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
      end
     end



    def user_params
      params.require(:user).permit(:first_name, :last_name, :email)
    end
end
