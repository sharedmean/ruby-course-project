class ApplicationController < ActionController::Base
  include Pundit::Authorization 
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  # protect_from_forgery with: exception # prevent CSRF attacks? not sure, google later

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :email, :password, :password_confirmation]) 
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :email, :password, :password_confirmation, :current_password, :avatar]) 
  end
end
