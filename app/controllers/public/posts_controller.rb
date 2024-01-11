class Public::PostsController < ApplicationController
  before_action :authenticate_user!
  def new
    @post = Post.new
  end

  def create
    post = Post.new(post_params)
    post.user_id = current_user.id
    post.save
    redirect_to posts_path
  end

  def index
   @posts =Post.all
  end

  def show
  end

  def edit
  end


  private
  # ストロングパラメータ

  def post_params
    params.require(:post).permit(:eaten_at, :meal_content, :image, :genre_id)
  end

end
