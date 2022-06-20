class UsersController < ApplicationController

  def index
    if params[:username]
      @users = User.where('username LIKE ?', "%#{params[:username]}%")
    else
      @users = User.all
    end
  end   

end 