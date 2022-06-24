class FollowsController < ApplicationController
  def create
    @follow = Follow.new(follow_params)
    authorize @follow
    @follow.save
     
    respond_to do |format|
      format.js { render inline: "location.reload();" }
    end 
  end
  
  def destroy
    @follow = current_user.following_follows.find_by(following_id: params[:id])
    @follow.destroy
    
    respond_to do |format|
      format.js { render inline: "location.reload();" }
    end 
  end

  private def follow_params
    params.require(:follow).permit(:following_id, :follower_id)
  end
end
