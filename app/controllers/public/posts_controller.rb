class Public::PostsController < ApplicationController
  before_action :authenticate_user!
  # before_action :user_admin, only: [:index]

  def new
    @post = Post.new
    @user = current_user
    @todos = @user ? @user.todos.all : nil
    @checked_todos_count = 0
  end

  def create
    @user = current_user
    @todos = @user ? @user.todos.all : nil
    checked_todo_ids = params[:todos]
    @checked_todos_count = checked_todo_ids.count if checked_todo_ids.present?
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to posts_path
    else
      flash[:danger] = "投稿に失敗しました。"
      render 'new'
    end
  end

  def index

    @posts = Post.where(user_id: current_user.id).order(eaten_at: :asc)
    @genre_id = params[:genre_id]
    @start_date = params[:start_date]
    @end_date = params[:end_date]

    if @genre_id.present?
      @posts = @posts.where(genre_id: @genre_id).order(eaten_at: :asc)
    end
    if @start_date.present? && @end_date.present?
      start_datetime = DateTime.strptime(@start_date, '%Y-%m-%d')
      end_datetime = DateTime.strptime(@end_date, '%Y-%m-%d').end_of_day
      @posts = @posts.where(eaten_at: start_datetime..end_datetime).order(eaten_at: :asc)
    end
     @checked_todos_count = params[:todos].size if params[:todos].present?
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

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to posts_path


  end


  private
  # ストロングパラメータ

  def post_params
    params.require(:post).permit(:eaten_at, :meal_content, :image, :genre_id)
  end

end
