class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :update_allowed_parameters, if: :devise_controller?

  def after_sign_in_path_for(_resource)
    recipes_path
  end


  protected

  def update_allowed_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password, :password_confirmation) }
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :email, :password, :current_password) }
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to unauthorized_path, alert: exception.message
  end
end
