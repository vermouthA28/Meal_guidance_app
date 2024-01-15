class Admin::TodosController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @todos = Todo.all
    @user = User.find(params[:user_id])
  end
  
  def new
    @todo = Todo.new
    @user = User.find(params[:user_id])
  end
  
  def create
    @user = User.find(params[:user_id])
    @todo = @user.todos.build(todo_params)
    @todo.admin = current_admin
    if @todo.save
      redirect_to admin_user_todos_path(@user), notice: 'ToDoが作成されました。'
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:user_id])
    @todo = Todo.find(params[:id])
  end
  
  def update
    @user = User.find(params[:user_id])
    @todo = Todo.find(params[:id])
    if @todo.update(todo_params)
      redirect_to admin_user_todos_path(@user), notice: 'ToDoが更新されました。'
    else
      render'edit'
    end
  end
  
  private
  def todo_params
    params.require(:todo).permit(:todo, :user_id, :admin_id)
  end
  
  
  
end
