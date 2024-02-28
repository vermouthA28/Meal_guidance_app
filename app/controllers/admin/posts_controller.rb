class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.order(eaten_at: :desc).page(params[:page]).per(8)
  end

  def show
    @user = User.find(params[:user_id])
    @post = Post.find(params[:id])
    @comment = Comment.new
  end

  def create
  @post = current_admin.post.new(post_params)
  @post.save

end

end
