class UsersController < ApplicationController

  def index
    if params[:username]
      @users = User.where('username LIKE ?', "%#{params[:username]}%")
    elsif params[:user_follower_id]
      follows = User.find(params[:user_follower_id]).following_follows.select('following_id')
      @users = User.where("id in (?)", follows)
    elsif params[:user_following_id]
      follows = User.find(params[:user_following_id]).follower_follows.select('follower_id')
      @users = User.where("id in (?)", follows)
    else
      @users = User.all
    end
  end   

end 