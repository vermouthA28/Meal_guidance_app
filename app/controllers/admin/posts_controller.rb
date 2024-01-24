class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.order(eaten_at: :asc).page(params[:page]).per(4)


  end

  def show
    @user = User.find(params[:user_id])
    @post = Post.find(params[:id])
    @comment = Comment.new


  end

end
