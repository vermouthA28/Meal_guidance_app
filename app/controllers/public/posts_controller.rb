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
   @posts = Post.where(user_id: current_user.id)
  end

  def show
  end

  def edit
  end


  private
  # ストロングパラメータ

    # def user_admin
    #   @users = User.all
    #   if  current_user.admin == true
    #       redirect_to root_path
    #   else
    #       render action: "index"
    #   end
    # end

  def post_params
    params.require(:post).permit(:eaten_at, :meal_content, :image, :genre_id)
  end

end
