class Admin::CommentsController < ApplicationController
  before_action :authenticate_admin!
  
  def create
    post = Post.find(params[:post_id])
    comment = post.comments.new(post_comment_params)
    comment.post_id = post.id
    comment.save
    redirect_to request.referer
  end
  
  def destroy
    comment = PostComment.find(params[:id])
    comment.destroy
  end
  
  private
  
  def post_comment_params
    params.require(:comment).permit(:post_id, :admin_id, :comment)
  
  end
end
