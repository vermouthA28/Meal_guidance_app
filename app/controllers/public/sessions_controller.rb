# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
before_action :user_state, only: [:create]

  def guest_sign_in
    user = User.guest #(admin_id: params[:admin_id])
    sign_in user
    redirect_to new_post_path(user), success:  "ゲストユーザーでログインしました。"
  end


  def after_sign_in_path_for(resource)
    new_post_path
  end

  def destroy
    reset_guest_data if current_user.email == User::GUEST_USER_EMAIL
    super
  end


  private

    def user_state
      user = User.find_by(email: params[:user][:email])
      return if user.nil?
      return unless user.valid_password?(params[:user][:password])
    end

  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  #def create
  #  super
    #redirect_to root_path
  #end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

end
