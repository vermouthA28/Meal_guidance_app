class Public::PostsController < ApplicationController
  before_action :authenticate_user!
  # before_action :user_admin, only: [:index]

  def new
    @post = Post.new
    @user = current_user
    @todos = @user.todos.all
  end

  def create
    post = Post.new(post_params)
    post.user_id = current_user.id
    post.save
    redirect_to posts_path
  end

  def index
   @posts = Post.where(user_id: current_user.id).order(eaten_at: :asc)
    @genre_id = params[:genre_id]
    if @genre_id.present?
      @posts = Post.where(user_id: current_user.id, genre_id: @genre_id).order(eaten_at: :asc)
    else
      @posts = Post.where(user_id: current_user.id).order(eaten_at: :asc)
    end
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
