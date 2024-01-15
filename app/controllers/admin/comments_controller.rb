class Admin::CommentsController < ApplicationController
  before_action :authenticate_admin!
  
  
  # def create
  #   post = Post.find(params[:post_id])
  #   if current_user.admin?
  #     @comment = Comment.new(comment_params)
  #     @comment.post_id = post.id
  #     @comment.save
  #     redirect_to request.referer
  #   else
  #     redirect_to root_path, notice: "管理者以外はコメントを作成できません。"
  #   end
  # end
  
  def create
    post = Post.find_by(id: params[:post_id])
    if post
      @comment = Comment.new(comment_params)
      @comment.post_id = post.id
      @comment.admin = current_admin
      @comment.save!
    redirect_to request.referer
    else
      # エラー処理またはログ出力など、投稿が見つからなかった場合の対応を行う
      flash[:error] = "投稿が見つかりませんでした。"
      redirect_to request.referer
    end
  end
  
  def destroy
  comment = Comment.find(params[:id]) 
  comment.destroy 
  redirect_to request.referer 
  end
 
  
  private
  
  def comment_params
    params.require(:comment).permit(:post_id, :admin_id, :comment)
  
  end
end
