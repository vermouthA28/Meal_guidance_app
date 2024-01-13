class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts
   

  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
  end

end
