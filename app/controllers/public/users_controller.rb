class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  def show
  end

  def edit
  end

  def confirm_withdraw
  end
end
