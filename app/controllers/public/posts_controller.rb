class Public::PostsController < ApplicationController
  before_action :authenticate_user!
  # before_action :user_admin, only: [:index]

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
   @posts = Post.where(user_id: current_user.id).order(eaten_at: :asc)
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    post = Post.find(params[:id])
    post.update(post_params)
    redirect_to post_path(post.id)

  end


  private
  # ストロングパラメータ

  def post_params
    params.require(:post).permit(:eaten_at, :meal_content, :image, :genre_id)
  end

end
