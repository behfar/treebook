class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Added to hopefully make devise work with Rails 4.
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:first_name, :last_name, :profile_name, :email) }
  end

  # For devise and Rails 4
  before_action :authenticate_user!

end
