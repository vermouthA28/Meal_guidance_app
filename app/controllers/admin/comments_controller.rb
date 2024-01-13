class Admin::CommentsController < ApplicationController
  before_action :authenticate_admin!
  
  def create
    post = Post.find(params[:post_id])
    if current_user.admin?
      @comment = Comment.new(comment_params)
    # comment = post.comments.new(comment_params)
      comment.post_id = post.id
      comment.save
      redirect_to request.referer
    else
      redirect_to root_path, notice: "管理者以外はコメントを作成できません。"
    end
    
  end
  
  def destroy
    comment = PostComment.find(params[:id])
    comment.destroy
  end
  
  private
  
  def comment_params
    params.require(:comment).permit(:post_id, :admin_id, :comment)
  
  end
end
