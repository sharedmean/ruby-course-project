class LikesController < ApplicationController
  def create
    @like = current_user.likes.new(like_params)
    @like.save

    respond_to do |format|
      format.js { render inline: "location.reload();" }
    end 
  end
  
  def destroy
    @like = current_user.likes.find(params[:id])
    @like.destroy
    
    respond_to do |format|
      format.js { render inline: "location.reload();" }
    end 
  end

  private def like_params
    params.require(:like).permit(:post_id)
  end
end
