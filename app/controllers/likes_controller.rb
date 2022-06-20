class LikesController < ApplicationController
  def create
    @like = current_user.likes.new(like_params)

    if !@like.save
      flash[:notice] = @like.errors.full_messages.to_sentence
    end

    respond_to do |format|
      format.js { render inline: "location.reload();" }
    end 
  end
  
  def destroy
    
    @like = current_user.likes.find(params[:id])
    likeable = @like.post
    @like.destroy
    
    respond_to do |format|
      format.js { render inline: "location.reload();" }
    end 
    
  end

  private def like_params
    params.require(:like).permit(:post_id)
  end
end
