class User::AvatarsController < ApplicationController

    def update
      if !current_user.update(avatar_params)
        flash[:notice] = "An error has occured. Please, try again."
      end
  
      respond_to do |format|
        format.js { render inline: "location.reload();" }
      end 
    end
  
    private def avatar_params
      params.require(:avatar).permit(:avatar)
    end
  end
  