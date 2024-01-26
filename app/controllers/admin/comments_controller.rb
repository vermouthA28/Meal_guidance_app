class Admin::CommentsController < ApplicationController
  before_action :authenticate_admin!



  def create
    post = Post.find_by(id: params[:post_id])
    if post
      @comment = Comment.new(comment_params)
      @comment.post_id = post.id
      @comment.admin = current_admin
      @comment.save!
    redirect_to request.referer, notice: 'コメントの作成に成功しました'
    else
      # エラー処理またはログ出力など、投稿が見つからなかった場合の対応を行う
      flash[:error] = "投稿が見つかりませんでした。"
      redirect_to request.referer
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    redirect_to request.referer, notice: 'コメントの削除に成功しました'
  end


  private

  def comment_params
    params.require(:comment).permit(:post_id, :admin_id, :comment)

  end
end
