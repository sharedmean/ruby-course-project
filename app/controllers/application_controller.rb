class ApplicationController < ActionController::Base
  
  before_action :configure_permitted_parameters, if: :devise_controller?

  # protect_from_forgery with: exception # prevent CSRF attacks? not sure, google later

 def configure_permitted_parameters
  devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :email, :password, :password_confirmation]) 
 end
end
