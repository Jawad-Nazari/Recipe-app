class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def after_sign_in_path_for(_resource)
    recipes_path
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to unauthorized_path, alert: exception.message
  end
end
