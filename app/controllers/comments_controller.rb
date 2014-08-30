class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @comment.author = current_user
    
    flash[:comment_errors] = @comment.errors.full_messages unless @comment.save
    
    redirect_to post_url(current_post)
  end
  
  def show
    @comment = Comment.find(params[:id])
  end
  
  private
  
  def comment_params
    params.require(:comment).permit(:content, :post_id, :parent_id)
  end
  
  def current_post
    @post ||= Post.find(comment_params[:post_id])
  end
end
