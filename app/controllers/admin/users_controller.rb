class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @members = current_admin.users.page(params[:page]).per(6)
   
  end

  def show
    @user = current_admin.users.find_by(id: params[:id])
    @user_posts = @user.posts.order(created_at: :desc)
  end

  def edit
    @user = current_admin.users.find_by(id: params[:id])
  end

  def update
    @user = current_admin.users.find_by(id: params[:id])
    if @user.update(user_params)
      redirect_to admin_user_path(@user), notice: "会員情報を更新しました"
    else
      flash[:error] = '会員情報の変更ができませんでした'
      render :edit
    end
  end


  private

  def user_params
    params.require(:user).permit(:last_name, :first_name, :email, :is_active ,:admin_id)
  end

end