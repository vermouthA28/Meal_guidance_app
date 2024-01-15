class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  def index
    @users = User.all
    

  end

  def show
    @user = User.find(params[:id])
    @user_posts = @user.posts.order(created_at: :desc)
    byebug
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
     @user = User.find(params[:id])
      if @user.update(user_params)
        if user_params[:is_active] == "0" && @user.is_active
          @user.update(is_active: false)
          flash[:notice] = "ユーザーを退会させました。"
        elsif user_params[:is_active] == "1" && !@user.is_active
          @user.update(is_active: true)
          flash[:notice]= "ユーザーを有効化しました。"
        else
          flash[:notice] = "会員ステータスを更新しました。"
        end
        redirect_to admin_user_path(@user), notice: flash[:notice]
      else
        render :edit

      end
  end



  private

  def user_params
    params.require(:user).permit(:last_name, :first_name, :email, :is_active ,:admin_id)
  end

end
