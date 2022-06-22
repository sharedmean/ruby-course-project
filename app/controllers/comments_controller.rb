class CommentsController < ApplicationController
  
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      redirect_to @post
    else
      flash[:notice] = "An error has occured during your comment creation. Please, try again."
      redirect_to @post
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    authorize @comment
    
    if @comment.destroy
      redirect_to @post
    else
      flash[:notice] = "An error has occured during your comment deletion. Please, try again."
      redirect_to @post
    end
  end

  private def comment_params
    params.require(:comment).permit(:body)
  end
end
