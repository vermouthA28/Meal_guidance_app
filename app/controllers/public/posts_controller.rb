class Public::PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :is_matching_login_user, only: [:show, :edit, :update]


  def new
    @post = Post.new
    @user = current_user
    @todos = @user ? @user.todos.all : nil

    if current_user.guest_user?
      @guest_user = true
    end
  end

  def create
    @user = current_user
    @todos = @user ? @user.todos.all : nil
    @post = Post.new(post_params)
    @post.user_id = current_user.id

    if @post.save
      redirect_to posts_path, notice: "投稿に成功しました。"
    else
      flash[:error] = '投稿に失敗しました'
      render 'new'
    end
  end

  def index
    @posts = Post.where(user_id: current_user.id).order(eaten_at: :desc).page(params[:page]).per(8)
    @genre_id = params[:genre_id]
    @start_date = params[:start_date]
    @end_date = params[:end_date]
    @selected_todos = Todo.where(id: params[:todo_ids])
    @count = @selected_todos.count if @selected_todos.present?

    if @genre_id.present?
      @posts = @posts.where(genre_id: @genre_id).order(eaten_at: :desc)
    end

    if @start_date.present? && @end_date.present?
      start_datetime = DateTime.strptime(@start_date, '%Y-%m-%d')
      end_datetime = DateTime.strptime(@end_date, '%Y-%m-%d').end_of_day
      @posts = @posts.where(eaten_at: start_datetime..end_datetime).order(eaten_at: :desc)
    end

  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
    @user = current_user
    @todos = @user ? @user.todos.all : nil
  end

  def update
    @post = Post.find(params[:id])
    @user = current_user
    @todos = @user ? @user.todos.all : nil

    if @post.update(post_params)
      redirect_to post_path(@post), notice: "投稿の編集に成功しました。"
    else
      flash[:error] = '投稿の編集に失敗しました'
      render 'edit'
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to posts_path, notice: "投稿の削除に成功しました"
  end

  def checked
    @post_todos = Post.new(checked_params)
    @post_todos.save
  end

  private

  def post_params
    params.require(:post).permit(:eaten_at, :meal_content, :genre_id, todo_ids: [], images: [] )
  end

  def checked_params
    params.require(:post).permit(todo_ids: []).merge(user_id: current_user.id)
  end

  def is_matching_login_user
    post = Post.find(params[:id])

    unless current_user.guest_user? || post.user.id == current_user.id
      redirect_to posts_path
    end
  end

end
